{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "67ef5a71",
   "metadata": {
    "papermill": {
     "duration": 0.096924,
     "end_time": "2022-03-29T18:34:40.786830",
     "exception": false,
     "start_time": "2022-03-29T18:34:40.689906",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**Cyclistic Bike Share Case Study**\n",
    "\n",
    "This project will be following the method: ASK-PREPARE-PROCESS-ANALYZE-SHARE-ACT.\n",
    "\n",
    "**ASK**\n",
    "\n",
    "**Business Task**:\n",
    "\n",
    "Cyclistic, a bike-share company in Chicago, features more than 5,800 bicycles and 600 docking stations. The director of marketing, Lily Moreno, believes the future success of the company depends on maximizing the number of annual members. Therefore, as a member of the marketing analytics team, I will be working on the project to understand how the casual riders and member riders differ, and help design a marketing strategy to convert casual riders to annual members. The marketing analytics team will be providing recommendations to the stakeholders, the director of marketing and the executive team,with compelling data insights and data visualizations.\n",
    "\n",
    "**PREPARE**\n",
    "\n",
    "Since Cyclistic is a fictional bike-share company, the data that will be used in this case study comes from the City of Chicago’s Divvy bicycle sharing service and it has been made available by Motivate International Inc. under a license. The data is public and well organized with no bias, and it’s credible and ROCCC.The data contains no personal identifiable information, and it’s integrated with the information that is needed for the case study. However, there are some values missing or incomplete, and they will be processed during data cleaning."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d1522197",
   "metadata": {
    "papermill": {
     "duration": 0.093436,
     "end_time": "2022-03-29T18:34:40.972341",
     "exception": false,
     "start_time": "2022-03-29T18:34:40.878905",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**PROCESS**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "f31ba280",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:34:41.164077Z",
     "iopub.status.busy": "2022-03-29T18:34:41.162845Z",
     "iopub.status.idle": "2022-03-29T18:34:42.426656Z",
     "shell.execute_reply": "2022-03-29T18:34:42.424879Z"
    },
    "papermill": {
     "duration": 1.361648,
     "end_time": "2022-03-29T18:34:42.426821",
     "exception": false,
     "start_time": "2022-03-29T18:34:41.065173",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching packages\u001b[22m ─────────────────────────────────────── tidyverse 1.3.1 ──\n",
      "\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2\u001b[39m 3.3.5     \u001b[32m✔\u001b[39m \u001b[34mpurrr  \u001b[39m 0.3.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtibble \u001b[39m 3.1.5     \u001b[32m✔\u001b[39m \u001b[34mdplyr  \u001b[39m 1.0.7\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtidyr  \u001b[39m 1.1.4     \u001b[32m✔\u001b[39m \u001b[34mstringr\u001b[39m 1.4.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mreadr  \u001b[39m 2.0.2     \u001b[32m✔\u001b[39m \u001b[34mforcats\u001b[39m 0.5.1\n",
      "\n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\n",
      "\n",
      "Attaching package: ‘lubridate’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:base’:\n",
      "\n",
      "    date, intersect, setdiff, union\n",
      "\n",
      "\n"
     ]
    }
   ],
   "source": [
    "# load packages needed\n",
    "library(tidyverse) #helps wrangle data\n",
    "library(lubridate) #helps wrangle date attributes\n",
    "library(ggplot2)   #helps visualize data"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "d6634ebb",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:34:42.661617Z",
     "iopub.status.busy": "2022-03-29T18:34:42.629681Z",
     "iopub.status.idle": "2022-03-29T18:36:22.350026Z",
     "shell.execute_reply": "2022-03-29T18:36:22.348837Z"
    },
    "papermill": {
     "duration": 99.823179,
     "end_time": "2022-03-29T18:36:22.350174",
     "exception": false,
     "start_time": "2022-03-29T18:34:42.526995",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# upload datasets (csv files) here\n",
    "Jan_2021 <- read.csv('../input/d/haocstks/cyclistic/202101-divvy-tripdata.csv')\n",
    "Feb_2021 <- read.csv('../input/d/haocstks/cyclistic/202102-divvy-tripdata.csv')\n",
    "Mar_2021 <- read.csv('../input/d/haocstks/cyclistic/202103-divvy-tripdata.csv')\n",
    "Apr_2021 <- read.csv('../input/d/haocstks/cyclistic/202104-divvy-tripdata.csv')\n",
    "May_2021 <- read.csv('../input/d/haocstks/cyclistic/202105-divvy-tripdata.csv')\n",
    "Jun_2021 <- read.csv('../input/d/haocstks/cyclistic/202106-divvy-tripdata.csv')\n",
    "Jul_2021 <- read.csv('../input/d/haocstks/cyclistic/202107-divvy-tripdata.csv')\n",
    "Aug_2021 <- read.csv('../input/d/haocstks/cyclistic/202108-divvy-tripdata.csv')\n",
    "Sep_2021 <- read.csv('../input/d/haocstks/cyclistic/202109-divvy-tripdata.csv')\n",
    "Oct_2021 <- read.csv('../input/d/haocstks/cyclistic/202110-divvy-tripdata.csv')\n",
    "Nov_2021 <- read.csv('../input/d/haocstks/cyclistic/202111-divvy-tripdata.csv')\n",
    "Dec_2021 <- read.csv('../input/d/haocstks/cyclistic/202112-divvy-tripdata.csv')"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "2e06feb5",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:36:22.550668Z",
     "iopub.status.busy": "2022-03-29T18:36:22.549178Z",
     "iopub.status.idle": "2022-03-29T18:36:22.623837Z",
     "shell.execute_reply": "2022-03-29T18:36:22.622308Z"
    },
    "papermill": {
     "duration": 0.17604,
     "end_time": "2022-03-29T18:36:22.623993",
     "exception": false,
     "start_time": "2022-03-29T18:36:22.447953",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#compare column names each of the files. The names don't have to be in the exactly same order, but they need to match before we can use a commend to combine them into one file.\n",
    "colnames(Jan_2021)\n",
    "colnames(Feb_2021)\n",
    "colnames(Mar_2021)\n",
    "colnames(Apr_2021)\n",
    "colnames(May_2021)\n",
    "colnames(Jun_2021)\n",
    "colnames(Jul_2021)\n",
    "colnames(Aug_2021)\n",
    "colnames(Sep_2021)\n",
    "colnames(Oct_2021)\n",
    "colnames(Nov_2021)\n",
    "colnames(Dec_2021)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "a24c3a75",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:36:22.892509Z",
     "iopub.status.busy": "2022-03-29T18:36:22.891873Z",
     "iopub.status.idle": "2022-03-29T18:36:23.192520Z",
     "shell.execute_reply": "2022-03-29T18:36:23.191216Z"
    },
    "papermill": {
     "duration": 0.43844,
     "end_time": "2022-03-29T18:36:23.192668",
     "exception": false,
     "start_time": "2022-03-29T18:36:22.754228",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t96834 obs. of  13 variables:\n",
      " $ ride_id           : chr  \"E19E6F1B8D4C42ED\" \"DC88F20C2C55F27F\" \"EC45C94683FE3F27\" \"4FA453A75AE377DB\" ...\n",
      " $ rideable_type     : chr  \"electric_bike\" \"electric_bike\" \"electric_bike\" \"electric_bike\" ...\n",
      " $ started_at        : chr  \"2021-01-23 16:14:19\" \"2021-01-27 18:43:08\" \"2021-01-21 22:35:54\" \"2021-01-07 13:31:13\" ...\n",
      " $ ended_at          : chr  \"2021-01-23 16:24:44\" \"2021-01-27 18:47:12\" \"2021-01-21 22:37:14\" \"2021-01-07 13:42:55\" ...\n",
      " $ start_station_name: chr  \"California Ave & Cortez St\" \"California Ave & Cortez St\" \"California Ave & Cortez St\" \"California Ave & Cortez St\" ...\n",
      " $ start_station_id  : chr  \"17660\" \"17660\" \"17660\" \"17660\" ...\n",
      " $ end_station_name  : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ end_station_id    : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ start_lat         : num  41.9 41.9 41.9 41.9 41.9 ...\n",
      " $ start_lng         : num  -87.7 -87.7 -87.7 -87.7 -87.7 ...\n",
      " $ end_lat           : num  41.9 41.9 41.9 41.9 41.9 ...\n",
      " $ end_lng           : num  -87.7 -87.7 -87.7 -87.7 -87.7 ...\n",
      " $ member_casual     : chr  \"member\" \"member\" \"member\" \"member\" ...\n",
      "'data.frame':\t49622 obs. of  13 variables:\n",
      " $ ride_id           : chr  \"89E7AA6C29227EFF\" \"0FEFDE2603568365\" \"E6159D746B2DBB91\" \"B32D3199F1C2E75B\" ...\n",
      " $ rideable_type     : chr  \"classic_bike\" \"classic_bike\" \"electric_bike\" \"classic_bike\" ...\n",
      " $ started_at        : chr  \"2021-02-12 16:14:56\" \"2021-02-14 17:52:38\" \"2021-02-09 19:10:18\" \"2021-02-02 17:49:41\" ...\n",
      " $ ended_at          : chr  \"2021-02-12 16:21:43\" \"2021-02-14 18:12:09\" \"2021-02-09 19:19:10\" \"2021-02-02 17:54:06\" ...\n",
      " $ start_station_name: chr  \"Glenwood Ave & Touhy Ave\" \"Glenwood Ave & Touhy Ave\" \"Clark St & Lake St\" \"Wood St & Chicago Ave\" ...\n",
      " $ start_station_id  : chr  \"525\" \"525\" \"KA1503000012\" \"637\" ...\n",
      " $ end_station_name  : chr  \"Sheridan Rd & Columbia Ave\" \"Bosworth Ave & Howard St\" \"State St & Randolph St\" \"Honore St & Division St\" ...\n",
      " $ end_station_id    : chr  \"660\" \"16806\" \"TA1305000029\" \"TA1305000034\" ...\n",
      " $ start_lat         : num  42 42 41.9 41.9 41.8 ...\n",
      " $ start_lng         : num  -87.7 -87.7 -87.6 -87.7 -87.6 ...\n",
      " $ end_lat           : num  42 42 41.9 41.9 41.8 ...\n",
      " $ end_lng           : num  -87.7 -87.7 -87.6 -87.7 -87.6 ...\n",
      " $ member_casual     : chr  \"member\" \"casual\" \"member\" \"member\" ...\n",
      "'data.frame':\t228496 obs. of  13 variables:\n",
      " $ ride_id           : chr  \"CFA86D4455AA1030\" \"30D9DC61227D1AF3\" \"846D87A15682A284\" \"994D05AA75A168F2\" ...\n",
      " $ rideable_type     : chr  \"classic_bike\" \"classic_bike\" \"classic_bike\" \"classic_bike\" ...\n",
      " $ started_at        : chr  \"2021-03-16 08:32:30\" \"2021-03-28 01:26:28\" \"2021-03-11 21:17:29\" \"2021-03-11 13:26:42\" ...\n",
      " $ ended_at          : chr  \"2021-03-16 08:36:34\" \"2021-03-28 01:36:55\" \"2021-03-11 21:33:53\" \"2021-03-11 13:55:41\" ...\n",
      " $ start_station_name: chr  \"Humboldt Blvd & Armitage Ave\" \"Humboldt Blvd & Armitage Ave\" \"Shields Ave & 28th Pl\" \"Winthrop Ave & Lawrence Ave\" ...\n",
      " $ start_station_id  : chr  \"15651\" \"15651\" \"15443\" \"TA1308000021\" ...\n",
      " $ end_station_name  : chr  \"Stave St & Armitage Ave\" \"Central Park Ave & Bloomingdale Ave\" \"Halsted St & 35th St\" \"Broadway & Sheridan Rd\" ...\n",
      " $ end_station_id    : chr  \"13266\" \"18017\" \"TA1308000043\" \"13323\" ...\n",
      " $ start_lat         : num  41.9 41.9 41.8 42 42 ...\n",
      " $ start_lng         : num  -87.7 -87.7 -87.6 -87.7 -87.7 ...\n",
      " $ end_lat           : num  41.9 41.9 41.8 42 42.1 ...\n",
      " $ end_lng           : num  -87.7 -87.7 -87.6 -87.6 -87.7 ...\n",
      " $ member_casual     : chr  \"casual\" \"casual\" \"casual\" \"casual\" ...\n",
      "'data.frame':\t337230 obs. of  13 variables:\n",
      " $ ride_id           : chr  \"6C992BD37A98A63F\" \"1E0145613A209000\" \"E498E15508A80BAD\" \"1887262AD101C604\" ...\n",
      " $ rideable_type     : chr  \"classic_bike\" \"docked_bike\" \"docked_bike\" \"classic_bike\" ...\n",
      " $ started_at        : chr  \"2021-04-12 18:25:36\" \"2021-04-27 17:27:11\" \"2021-04-03 12:42:45\" \"2021-04-17 09:17:42\" ...\n",
      " $ ended_at          : chr  \"2021-04-12 18:56:55\" \"2021-04-27 18:31:29\" \"2021-04-07 11:40:24\" \"2021-04-17 09:42:48\" ...\n",
      " $ start_station_name: chr  \"State St & Pearson St\" \"Dorchester Ave & 49th St\" \"Loomis Blvd & 84th St\" \"Honore St & Division St\" ...\n",
      " $ start_station_id  : chr  \"TA1307000061\" \"KA1503000069\" \"20121\" \"TA1305000034\" ...\n",
      " $ end_station_name  : chr  \"Southport Ave & Waveland Ave\" \"Dorchester Ave & 49th St\" \"Loomis Blvd & 84th St\" \"Southport Ave & Waveland Ave\" ...\n",
      " $ end_station_id    : chr  \"13235\" \"KA1503000069\" \"20121\" \"13235\" ...\n",
      " $ start_lat         : num  41.9 41.8 41.7 41.9 41.7 ...\n",
      " $ start_lng         : num  -87.6 -87.6 -87.7 -87.7 -87.7 ...\n",
      " $ end_lat           : num  41.9 41.8 41.7 41.9 41.7 ...\n",
      " $ end_lng           : num  -87.7 -87.6 -87.7 -87.7 -87.7 ...\n",
      " $ member_casual     : chr  \"member\" \"casual\" \"casual\" \"member\" ...\n",
      "'data.frame':\t531633 obs. of  13 variables:\n",
      " $ ride_id           : chr  \"C809ED75D6160B2A\" \"DD59FDCE0ACACAF3\" \"0AB83CB88C43EFC2\" \"7881AC6D39110C60\" ...\n",
      " $ rideable_type     : chr  \"electric_bike\" \"electric_bike\" \"electric_bike\" \"electric_bike\" ...\n",
      " $ started_at        : chr  \"2021-05-30 11:58:15\" \"2021-05-30 11:29:14\" \"2021-05-30 14:24:01\" \"2021-05-30 14:25:51\" ...\n",
      " $ ended_at          : chr  \"2021-05-30 12:10:39\" \"2021-05-30 12:14:09\" \"2021-05-30 14:25:13\" \"2021-05-30 14:41:04\" ...\n",
      " $ start_station_name: chr  \"\" \"\" \"\" \"\" ...\n",
      " $ start_station_id  : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ end_station_name  : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ end_station_id    : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ start_lat         : num  41.9 41.9 41.9 41.9 41.9 ...\n",
      " $ start_lng         : num  -87.6 -87.6 -87.7 -87.7 -87.7 ...\n",
      " $ end_lat           : num  41.9 41.8 41.9 41.9 41.9 ...\n",
      " $ end_lng           : num  -87.6 -87.6 -87.7 -87.7 -87.7 ...\n",
      " $ member_casual     : chr  \"casual\" \"casual\" \"casual\" \"casual\" ...\n",
      "'data.frame':\t729595 obs. of  13 variables:\n",
      " $ ride_id           : chr  \"99FEC93BA843FB20\" \"06048DCFC8520CAF\" \"9598066F68045DF2\" \"B03C0FE48C412214\" ...\n",
      " $ rideable_type     : chr  \"electric_bike\" \"electric_bike\" \"electric_bike\" \"electric_bike\" ...\n",
      " $ started_at        : chr  \"2021-06-13 14:31:28\" \"2021-06-04 11:18:02\" \"2021-06-04 09:49:35\" \"2021-06-03 19:56:05\" ...\n",
      " $ ended_at          : chr  \"2021-06-13 14:34:11\" \"2021-06-04 11:24:19\" \"2021-06-04 09:55:34\" \"2021-06-03 20:21:55\" ...\n",
      " $ start_station_name: chr  \"\" \"\" \"\" \"\" ...\n",
      " $ start_station_id  : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ end_station_name  : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ end_station_id    : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ start_lat         : num  41.8 41.8 41.8 41.8 41.8 ...\n",
      " $ start_lng         : num  -87.6 -87.6 -87.6 -87.6 -87.6 ...\n",
      " $ end_lat           : num  41.8 41.8 41.8 41.8 41.8 ...\n",
      " $ end_lng           : num  -87.6 -87.6 -87.6 -87.6 -87.6 ...\n",
      " $ member_casual     : chr  \"member\" \"member\" \"member\" \"member\" ...\n",
      "'data.frame':\t822410 obs. of  13 variables:\n",
      " $ ride_id           : chr  \"0A1B623926EF4E16\" \"B2D5583A5A5E76EE\" \"6F264597DDBF427A\" \"379B58EAB20E8AA5\" ...\n",
      " $ rideable_type     : chr  \"docked_bike\" \"classic_bike\" \"classic_bike\" \"classic_bike\" ...\n",
      " $ started_at        : chr  \"2021-07-02 14:44:36\" \"2021-07-07 16:57:42\" \"2021-07-25 11:30:55\" \"2021-07-08 22:08:30\" ...\n",
      " $ ended_at          : chr  \"2021-07-02 15:19:58\" \"2021-07-07 17:16:09\" \"2021-07-25 11:48:45\" \"2021-07-08 22:23:32\" ...\n",
      " $ start_station_name: chr  \"Michigan Ave & Washington St\" \"California Ave & Cortez St\" \"Wabash Ave & 16th St\" \"California Ave & Cortez St\" ...\n",
      " $ start_station_id  : chr  \"13001\" \"17660\" \"SL-012\" \"17660\" ...\n",
      " $ end_station_name  : chr  \"Halsted St & North Branch St\" \"Wood St & Hubbard St\" \"Rush St & Hubbard St\" \"Carpenter St & Huron St\" ...\n",
      " $ end_station_id    : chr  \"KA1504000117\" \"13432\" \"KA1503000044\" \"13196\" ...\n",
      " $ start_lat         : num  41.9 41.9 41.9 41.9 41.9 ...\n",
      " $ start_lng         : num  -87.6 -87.7 -87.6 -87.7 -87.7 ...\n",
      " $ end_lat           : num  41.9 41.9 41.9 41.9 41.9 ...\n",
      " $ end_lng           : num  -87.6 -87.7 -87.6 -87.7 -87.7 ...\n",
      " $ member_casual     : chr  \"casual\" \"casual\" \"member\" \"member\" ...\n",
      "'data.frame':\t804352 obs. of  13 variables:\n",
      " $ ride_id           : chr  \"99103BB87CC6C1BB\" \"EAFCCCFB0A3FC5A1\" \"9EF4F46C57AD234D\" \"5834D3208BFAF1DA\" ...\n",
      " $ rideable_type     : chr  \"electric_bike\" \"electric_bike\" \"electric_bike\" \"electric_bike\" ...\n",
      " $ started_at        : chr  \"2021-08-10 17:15:49\" \"2021-08-10 17:23:14\" \"2021-08-21 02:34:23\" \"2021-08-21 06:52:55\" ...\n",
      " $ ended_at          : chr  \"2021-08-10 17:22:44\" \"2021-08-10 17:39:24\" \"2021-08-21 02:50:36\" \"2021-08-21 07:08:13\" ...\n",
      " $ start_station_name: chr  \"\" \"\" \"\" \"\" ...\n",
      " $ start_station_id  : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ end_station_name  : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ end_station_id    : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ start_lat         : num  41.8 41.8 42 42 41.8 ...\n",
      " $ start_lng         : num  -87.7 -87.7 -87.7 -87.7 -87.6 ...\n",
      " $ end_lat           : num  41.8 41.8 42 42 41.8 ...\n",
      " $ end_lng           : num  -87.7 -87.6 -87.7 -87.7 -87.6 ...\n",
      " $ member_casual     : chr  \"member\" \"member\" \"member\" \"member\" ...\n",
      "'data.frame':\t756147 obs. of  13 variables:\n",
      " $ ride_id           : chr  \"9DC7B962304CBFD8\" \"F930E2C6872D6B32\" \"6EF72137900BB910\" \"78D1DE133B3DBF55\" ...\n",
      " $ rideable_type     : chr  \"electric_bike\" \"electric_bike\" \"electric_bike\" \"electric_bike\" ...\n",
      " $ started_at        : chr  \"2021-09-28 16:07:10\" \"2021-09-28 14:24:51\" \"2021-09-28 00:20:16\" \"2021-09-28 14:51:17\" ...\n",
      " $ ended_at          : chr  \"2021-09-28 16:09:54\" \"2021-09-28 14:40:05\" \"2021-09-28 00:23:57\" \"2021-09-28 15:00:06\" ...\n",
      " $ start_station_name: chr  \"\" \"\" \"\" \"\" ...\n",
      " $ start_station_id  : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ end_station_name  : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ end_station_id    : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ start_lat         : num  41.9 41.9 41.8 41.8 41.9 ...\n",
      " $ start_lng         : num  -87.7 -87.6 -87.7 -87.7 -87.7 ...\n",
      " $ end_lat           : num  41.9 42 41.8 41.8 41.9 ...\n",
      " $ end_lng           : num  -87.7 -87.7 -87.7 -87.7 -87.7 ...\n",
      " $ member_casual     : chr  \"casual\" \"casual\" \"casual\" \"casual\" ...\n",
      "'data.frame':\t631226 obs. of  13 variables:\n",
      " $ ride_id           : chr  \"620BC6107255BF4C\" \"4471C70731AB2E45\" \"26CA69D43D15EE14\" \"362947F0437E1514\" ...\n",
      " $ rideable_type     : chr  \"electric_bike\" \"electric_bike\" \"electric_bike\" \"electric_bike\" ...\n",
      " $ started_at        : chr  \"2021-10-22 12:46:42\" \"2021-10-21 09:12:37\" \"2021-10-16 16:28:39\" \"2021-10-16 16:17:48\" ...\n",
      " $ ended_at          : chr  \"2021-10-22 12:49:50\" \"2021-10-21 09:14:14\" \"2021-10-16 16:36:26\" \"2021-10-16 16:19:03\" ...\n",
      " $ start_station_name: chr  \"Kingsbury St & Kinzie St\" \"\" \"\" \"\" ...\n",
      " $ start_station_id  : chr  \"KA1503000043\" \"\" \"\" \"\" ...\n",
      " $ end_station_name  : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ end_station_id    : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ start_lat         : num  41.9 41.9 41.9 41.9 41.9 ...\n",
      " $ start_lng         : num  -87.6 -87.7 -87.7 -87.7 -87.7 ...\n",
      " $ end_lat           : num  41.9 41.9 41.9 41.9 41.9 ...\n",
      " $ end_lng           : num  -87.6 -87.7 -87.7 -87.7 -87.7 ...\n",
      " $ member_casual     : chr  \"member\" \"member\" \"member\" \"member\" ...\n",
      "'data.frame':\t359978 obs. of  13 variables:\n",
      " $ ride_id           : chr  \"7C00A93E10556E47\" \"90854840DFD508BA\" \"0A7D10CDD144061C\" \"2F3BE33085BCFF02\" ...\n",
      " $ rideable_type     : chr  \"electric_bike\" \"electric_bike\" \"electric_bike\" \"electric_bike\" ...\n",
      " $ started_at        : chr  \"2021-11-27 13:27:38\" \"2021-11-27 13:38:25\" \"2021-11-26 22:03:34\" \"2021-11-27 09:56:49\" ...\n",
      " $ ended_at          : chr  \"2021-11-27 13:46:38\" \"2021-11-27 13:56:10\" \"2021-11-26 22:05:56\" \"2021-11-27 10:01:50\" ...\n",
      " $ start_station_name: chr  \"\" \"\" \"\" \"\" ...\n",
      " $ start_station_id  : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ end_station_name  : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ end_station_id    : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ start_lat         : num  41.9 42 42 41.9 41.9 ...\n",
      " $ start_lng         : num  -87.7 -87.7 -87.7 -87.8 -87.6 ...\n",
      " $ end_lat           : num  42 41.9 42 41.9 41.9 ...\n",
      " $ end_lng           : num  -87.7 -87.7 -87.7 -87.8 -87.6 ...\n",
      " $ member_casual     : chr  \"casual\" \"casual\" \"casual\" \"casual\" ...\n",
      "'data.frame':\t247540 obs. of  13 variables:\n",
      " $ ride_id           : chr  \"46F8167220E4431F\" \"73A77762838B32FD\" \"4CF42452054F59C5\" \"3278BA87BF698339\" ...\n",
      " $ rideable_type     : chr  \"electric_bike\" \"electric_bike\" \"electric_bike\" \"classic_bike\" ...\n",
      " $ started_at        : chr  \"2021-12-07 15:06:07\" \"2021-12-11 03:43:29\" \"2021-12-15 23:10:28\" \"2021-12-26 16:16:10\" ...\n",
      " $ ended_at          : chr  \"2021-12-07 15:13:42\" \"2021-12-11 04:10:23\" \"2021-12-15 23:23:14\" \"2021-12-26 16:30:53\" ...\n",
      " $ start_station_name: chr  \"Laflin St & Cullerton St\" \"LaSalle Dr & Huron St\" \"Halsted St & North Branch St\" \"Halsted St & North Branch St\" ...\n",
      " $ start_station_id  : chr  \"13307\" \"KP1705001026\" \"KA1504000117\" \"KA1504000117\" ...\n",
      " $ end_station_name  : chr  \"Morgan St & Polk St\" \"Clarendon Ave & Leland Ave\" \"Broadway & Barry Ave\" \"LaSalle Dr & Huron St\" ...\n",
      " $ end_station_id    : chr  \"TA1307000130\" \"TA1307000119\" \"13137\" \"KP1705001026\" ...\n",
      " $ start_lat         : num  41.9 41.9 41.9 41.9 41.9 ...\n",
      " $ start_lng         : num  -87.7 -87.6 -87.6 -87.6 -87.7 ...\n",
      " $ end_lat           : num  41.9 42 41.9 41.9 41.9 ...\n",
      " $ end_lng           : num  -87.7 -87.7 -87.6 -87.6 -87.6 ...\n",
      " $ member_casual     : chr  \"member\" \"casual\" \"member\" \"member\" ...\n"
     ]
    }
   ],
   "source": [
    "#inspect the dataframes and look for incongruencies\n",
    "\n",
    "str(Jan_2021)\n",
    "str(Feb_2021)\n",
    "str(Mar_2021)\n",
    "str(Apr_2021)\n",
    "str(May_2021)\n",
    "str(Jun_2021)\n",
    "str(Jul_2021)\n",
    "str(Aug_2021)\n",
    "str(Sep_2021)\n",
    "str(Oct_2021)\n",
    "str(Nov_2021)\n",
    "str(Dec_2021)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "6920bd7a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:36:23.486898Z",
     "iopub.status.busy": "2022-03-29T18:36:23.484442Z",
     "iopub.status.idle": "2022-03-29T18:36:35.905798Z",
     "shell.execute_reply": "2022-03-29T18:36:35.904212Z"
    },
    "papermill": {
     "duration": 12.570003,
     "end_time": "2022-03-29T18:36:35.905968",
     "exception": false,
     "start_time": "2022-03-29T18:36:23.335965",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# stack individual month's data frames into one big data frame\n",
    "all_trips <- bind_rows(Jan_2021,Feb_2021,Mar_2021,Apr_2021,May_2021,Jun_2021,Jul_2021,Aug_2021,Sep_2021,Oct_2021,Nov_2021,Dec_2021)\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "80b5a1fc",
   "metadata": {
    "papermill": {
     "duration": 0.146318,
     "end_time": "2022-03-29T18:36:36.198075",
     "exception": false,
     "start_time": "2022-03-29T18:36:36.051757",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**Clean up data and add date**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "bfcadd4b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:36:36.493559Z",
     "iopub.status.busy": "2022-03-29T18:36:36.491549Z",
     "iopub.status.idle": "2022-03-29T18:36:36.520116Z",
     "shell.execute_reply": "2022-03-29T18:36:36.518485Z"
    },
    "papermill": {
     "duration": 0.17758,
     "end_time": "2022-03-29T18:36:36.520265",
     "exception": false,
     "start_time": "2022-03-29T18:36:36.342685",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# remove lat,long\n",
    "all_trips <- all_trips %>%\n",
    " select(-c(start_lat,start_lng,end_lat,end_lng))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "e4d34d7e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:36:36.819882Z",
     "iopub.status.busy": "2022-03-29T18:36:36.817826Z",
     "iopub.status.idle": "2022-03-29T18:36:36.895704Z",
     "shell.execute_reply": "2022-03-29T18:36:36.894247Z"
    },
    "papermill": {
     "duration": 0.230568,
     "end_time": "2022-03-29T18:36:36.895853",
     "exception": false,
     "start_time": "2022-03-29T18:36:36.665285",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       "[4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       "[7] \"end_station_name\"   \"end_station_id\"     \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "5595063"
      ],
      "text/latex": [
       "5595063"
      ],
      "text/markdown": [
       "5595063"
      ],
      "text/plain": [
       "[1] 5595063"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>5595063</li><li>9</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 5595063\n",
       "\\item 9\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 5595063\n",
       "2. 9\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 5595063       9"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>ride_id</th><th scope=col>rideable_type</th><th scope=col>started_at</th><th scope=col>ended_at</th><th scope=col>start_station_name</th><th scope=col>start_station_id</th><th scope=col>end_station_name</th><th scope=col>end_station_id</th><th scope=col>member_casual</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>E19E6F1B8D4C42ED</td><td>electric_bike</td><td>2021-01-23 16:14:19</td><td>2021-01-23 16:24:44</td><td>California Ave &amp; Cortez St</td><td>17660</td><td></td><td></td><td>member</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>DC88F20C2C55F27F</td><td>electric_bike</td><td>2021-01-27 18:43:08</td><td>2021-01-27 18:47:12</td><td>California Ave &amp; Cortez St</td><td>17660</td><td></td><td></td><td>member</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>EC45C94683FE3F27</td><td>electric_bike</td><td>2021-01-21 22:35:54</td><td>2021-01-21 22:37:14</td><td>California Ave &amp; Cortez St</td><td>17660</td><td></td><td></td><td>member</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>4FA453A75AE377DB</td><td>electric_bike</td><td>2021-01-07 13:31:13</td><td>2021-01-07 13:42:55</td><td>California Ave &amp; Cortez St</td><td>17660</td><td></td><td></td><td>member</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>BE5E8EB4E7263A0B</td><td>electric_bike</td><td>2021-01-23 02:24:02</td><td>2021-01-23 02:24:45</td><td>California Ave &amp; Cortez St</td><td>17660</td><td></td><td></td><td>casual</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>5D8969F88C773979</td><td>electric_bike</td><td>2021-01-09 14:24:07</td><td>2021-01-09 15:17:54</td><td>California Ave &amp; Cortez St</td><td>17660</td><td></td><td></td><td>casual</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 9\n",
       "\\begin{tabular}{r|lllllllll}\n",
       "  & ride\\_id & rideable\\_type & started\\_at & ended\\_at & start\\_station\\_name & start\\_station\\_id & end\\_station\\_name & end\\_station\\_id & member\\_casual\\\\\n",
       "  & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & E19E6F1B8D4C42ED & electric\\_bike & 2021-01-23 16:14:19 & 2021-01-23 16:24:44 & California Ave \\& Cortez St & 17660 &  &  & member\\\\\n",
       "\t2 & DC88F20C2C55F27F & electric\\_bike & 2021-01-27 18:43:08 & 2021-01-27 18:47:12 & California Ave \\& Cortez St & 17660 &  &  & member\\\\\n",
       "\t3 & EC45C94683FE3F27 & electric\\_bike & 2021-01-21 22:35:54 & 2021-01-21 22:37:14 & California Ave \\& Cortez St & 17660 &  &  & member\\\\\n",
       "\t4 & 4FA453A75AE377DB & electric\\_bike & 2021-01-07 13:31:13 & 2021-01-07 13:42:55 & California Ave \\& Cortez St & 17660 &  &  & member\\\\\n",
       "\t5 & BE5E8EB4E7263A0B & electric\\_bike & 2021-01-23 02:24:02 & 2021-01-23 02:24:45 & California Ave \\& Cortez St & 17660 &  &  & casual\\\\\n",
       "\t6 & 5D8969F88C773979 & electric\\_bike & 2021-01-09 14:24:07 & 2021-01-09 15:17:54 & California Ave \\& Cortez St & 17660 &  &  & casual\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 9\n",
       "\n",
       "| <!--/--> | ride_id &lt;chr&gt; | rideable_type &lt;chr&gt; | started_at &lt;chr&gt; | ended_at &lt;chr&gt; | start_station_name &lt;chr&gt; | start_station_id &lt;chr&gt; | end_station_name &lt;chr&gt; | end_station_id &lt;chr&gt; | member_casual &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | E19E6F1B8D4C42ED | electric_bike | 2021-01-23 16:14:19 | 2021-01-23 16:24:44 | California Ave &amp; Cortez St | 17660 | <!----> | <!----> | member |\n",
       "| 2 | DC88F20C2C55F27F | electric_bike | 2021-01-27 18:43:08 | 2021-01-27 18:47:12 | California Ave &amp; Cortez St | 17660 | <!----> | <!----> | member |\n",
       "| 3 | EC45C94683FE3F27 | electric_bike | 2021-01-21 22:35:54 | 2021-01-21 22:37:14 | California Ave &amp; Cortez St | 17660 | <!----> | <!----> | member |\n",
       "| 4 | 4FA453A75AE377DB | electric_bike | 2021-01-07 13:31:13 | 2021-01-07 13:42:55 | California Ave &amp; Cortez St | 17660 | <!----> | <!----> | member |\n",
       "| 5 | BE5E8EB4E7263A0B | electric_bike | 2021-01-23 02:24:02 | 2021-01-23 02:24:45 | California Ave &amp; Cortez St | 17660 | <!----> | <!----> | casual |\n",
       "| 6 | 5D8969F88C773979 | electric_bike | 2021-01-09 14:24:07 | 2021-01-09 15:17:54 | California Ave &amp; Cortez St | 17660 | <!----> | <!----> | casual |\n",
       "\n"
      ],
      "text/plain": [
       "  ride_id          rideable_type started_at          ended_at           \n",
       "1 E19E6F1B8D4C42ED electric_bike 2021-01-23 16:14:19 2021-01-23 16:24:44\n",
       "2 DC88F20C2C55F27F electric_bike 2021-01-27 18:43:08 2021-01-27 18:47:12\n",
       "3 EC45C94683FE3F27 electric_bike 2021-01-21 22:35:54 2021-01-21 22:37:14\n",
       "4 4FA453A75AE377DB electric_bike 2021-01-07 13:31:13 2021-01-07 13:42:55\n",
       "5 BE5E8EB4E7263A0B electric_bike 2021-01-23 02:24:02 2021-01-23 02:24:45\n",
       "6 5D8969F88C773979 electric_bike 2021-01-09 14:24:07 2021-01-09 15:17:54\n",
       "  start_station_name         start_station_id end_station_name end_station_id\n",
       "1 California Ave & Cortez St 17660                                           \n",
       "2 California Ave & Cortez St 17660                                           \n",
       "3 California Ave & Cortez St 17660                                           \n",
       "4 California Ave & Cortez St 17660                                           \n",
       "5 California Ave & Cortez St 17660                                           \n",
       "6 California Ave & Cortez St 17660                                           \n",
       "  member_casual\n",
       "1 member       \n",
       "2 member       \n",
       "3 member       \n",
       "4 member       \n",
       "5 casual       \n",
       "6 casual       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t5595063 obs. of  9 variables:\n",
      " $ ride_id           : chr  \"E19E6F1B8D4C42ED\" \"DC88F20C2C55F27F\" \"EC45C94683FE3F27\" \"4FA453A75AE377DB\" ...\n",
      " $ rideable_type     : chr  \"electric_bike\" \"electric_bike\" \"electric_bike\" \"electric_bike\" ...\n",
      " $ started_at        : chr  \"2021-01-23 16:14:19\" \"2021-01-27 18:43:08\" \"2021-01-21 22:35:54\" \"2021-01-07 13:31:13\" ...\n",
      " $ ended_at          : chr  \"2021-01-23 16:24:44\" \"2021-01-27 18:47:12\" \"2021-01-21 22:37:14\" \"2021-01-07 13:42:55\" ...\n",
      " $ start_station_name: chr  \"California Ave & Cortez St\" \"California Ave & Cortez St\" \"California Ave & Cortez St\" \"California Ave & Cortez St\" ...\n",
      " $ start_station_id  : chr  \"17660\" \"17660\" \"17660\" \"17660\" ...\n",
      " $ end_station_name  : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ end_station_id    : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ member_casual     : chr  \"member\" \"member\" \"member\" \"member\" ...\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "   ride_id          rideable_type       started_at          ended_at        \n",
       " Length:5595063     Length:5595063     Length:5595063     Length:5595063    \n",
       " Class :character   Class :character   Class :character   Class :character  \n",
       " Mode  :character   Mode  :character   Mode  :character   Mode  :character  \n",
       " start_station_name start_station_id   end_station_name   end_station_id    \n",
       " Length:5595063     Length:5595063     Length:5595063     Length:5595063    \n",
       " Class :character   Class :character   Class :character   Class :character  \n",
       " Mode  :character   Mode  :character   Mode  :character   Mode  :character  \n",
       " member_casual     \n",
       " Length:5595063    \n",
       " Class :character  \n",
       " Mode  :character  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# inspect the new table that has been created\n",
    "colnames(all_trips) # List of column names\n",
    "nrow(all_trips) # How many rows in the data frame\n",
    "dim(all_trips) # Dimensions of the data frame\n",
    "head(all_trips) # See the first 6 rows of the data frame\n",
    "str(all_trips) # See list of columns and data types (numeric,character etc.)\n",
    "summary(all_trips) # Statistical summary of data"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "9828723e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:36:37.222028Z",
     "iopub.status.busy": "2022-03-29T18:36:37.220067Z",
     "iopub.status.idle": "2022-03-29T18:36:38.590766Z",
     "shell.execute_reply": "2022-03-29T18:36:38.589362Z"
    },
    "papermill": {
     "duration": 1.532271,
     "end_time": "2022-03-29T18:36:38.590907",
     "exception": false,
     "start_time": "2022-03-29T18:36:37.058636",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       " casual  member \n",
       "2529005 3066058 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# See how many observations fall under each usertype\n",
    "table(all_trips$member_casual)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "03d7df45",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:36:38.914902Z",
     "iopub.status.busy": "2022-03-29T18:36:38.913468Z",
     "iopub.status.idle": "2022-03-29T18:36:59.721151Z",
     "shell.execute_reply": "2022-03-29T18:36:59.719218Z"
    },
    "papermill": {
     "duration": 20.970823,
     "end_time": "2022-03-29T18:36:59.721383",
     "exception": false,
     "start_time": "2022-03-29T18:36:38.750560",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# add colunms that list the date,month,day,and year of each ride\n",
    "# this will allow us to aggregate ride data for each month,day,or year...\n",
    "all_trips$date <- as.Date(all_trips$started_at) # the default format is yyyy-mm-dd\n",
    "all_trips$month <- format(as.Date(all_trips$date),\"%m\")\n",
    "all_trips$day <- format(as.Date(all_trips$date),\"%d\")\n",
    "all_trips$year <- format(as.Date(all_trips$date),\"%Y\")\n",
    "all_trips$day_of_week <- format(as.Date(all_trips$date),\"%A\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "b9d4e063",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:37:00.044479Z",
     "iopub.status.busy": "2022-03-29T18:37:00.042487Z",
     "iopub.status.idle": "2022-03-29T18:37:39.497800Z",
     "shell.execute_reply": "2022-03-29T18:37:39.496584Z"
    },
    "papermill": {
     "duration": 39.618344,
     "end_time": "2022-03-29T18:37:39.498022",
     "exception": false,
     "start_time": "2022-03-29T18:36:59.879678",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# calculate ride length in minutes\n",
    "all_trips$ride_length <- difftime(all_trips$ended_at,all_trips$started_at,units=\"mins\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "99b1a88f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:37:39.821518Z",
     "iopub.status.busy": "2022-03-29T18:37:39.820023Z",
     "iopub.status.idle": "2022-03-29T18:37:39.859532Z",
     "shell.execute_reply": "2022-03-29T18:37:39.858250Z"
    },
    "papermill": {
     "duration": 0.201124,
     "end_time": "2022-03-29T18:37:39.859716",
     "exception": false,
     "start_time": "2022-03-29T18:37:39.658592",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t5595063 obs. of  15 variables:\n",
      " $ ride_id           : chr  \"E19E6F1B8D4C42ED\" \"DC88F20C2C55F27F\" \"EC45C94683FE3F27\" \"4FA453A75AE377DB\" ...\n",
      " $ rideable_type     : chr  \"electric_bike\" \"electric_bike\" \"electric_bike\" \"electric_bike\" ...\n",
      " $ started_at        : chr  \"2021-01-23 16:14:19\" \"2021-01-27 18:43:08\" \"2021-01-21 22:35:54\" \"2021-01-07 13:31:13\" ...\n",
      " $ ended_at          : chr  \"2021-01-23 16:24:44\" \"2021-01-27 18:47:12\" \"2021-01-21 22:37:14\" \"2021-01-07 13:42:55\" ...\n",
      " $ start_station_name: chr  \"California Ave & Cortez St\" \"California Ave & Cortez St\" \"California Ave & Cortez St\" \"California Ave & Cortez St\" ...\n",
      " $ start_station_id  : chr  \"17660\" \"17660\" \"17660\" \"17660\" ...\n",
      " $ end_station_name  : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ end_station_id    : chr  \"\" \"\" \"\" \"\" ...\n",
      " $ member_casual     : chr  \"member\" \"member\" \"member\" \"member\" ...\n",
      " $ date              : Date, format: \"2021-01-23\" \"2021-01-27\" ...\n",
      " $ month             : chr  \"01\" \"01\" \"01\" \"01\" ...\n",
      " $ day               : chr  \"23\" \"27\" \"21\" \"07\" ...\n",
      " $ year              : chr  \"2021\" \"2021\" \"2021\" \"2021\" ...\n",
      " $ day_of_week       : chr  \"Saturday\" \"Wednesday\" \"Thursday\" \"Thursday\" ...\n",
      " $ ride_length       : 'difftime' num  10.4166666666667 4.06666666666667 1.33333333333333 11.7 ...\n",
      "  ..- attr(*, \"units\")= chr \"mins\"\n"
     ]
    }
   ],
   "source": [
    "# inspect the structure of the columns\n",
    "str(all_trips)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "508961b5",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:37:40.188755Z",
     "iopub.status.busy": "2022-03-29T18:37:40.187444Z",
     "iopub.status.idle": "2022-03-29T18:37:49.045012Z",
     "shell.execute_reply": "2022-03-29T18:37:49.043136Z"
    },
    "papermill": {
     "duration": 9.022092,
     "end_time": "2022-03-29T18:37:49.045214",
     "exception": false,
     "start_time": "2022-03-29T18:37:40.023122",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "FALSE"
      ],
      "text/latex": [
       "FALSE"
      ],
      "text/markdown": [
       "FALSE"
      ],
      "text/plain": [
       "[1] FALSE"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "TRUE"
      ],
      "text/latex": [
       "TRUE"
      ],
      "text/markdown": [
       "TRUE"
      ],
      "text/plain": [
       "[1] TRUE"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# convert \"ride_length\" from factor to numeric so we can do calculations on the data\n",
    "is.factor(all_trips$ride_length)\n",
    "all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))\n",
    "is.numeric(all_trips$ride_length)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "93a9bb0c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:37:49.381511Z",
     "iopub.status.busy": "2022-03-29T18:37:49.379829Z",
     "iopub.status.idle": "2022-03-29T18:37:54.214914Z",
     "shell.execute_reply": "2022-03-29T18:37:54.213227Z"
    },
    "papermill": {
     "duration": 5.004714,
     "end_time": "2022-03-29T18:37:54.215082",
     "exception": false,
     "start_time": "2022-03-29T18:37:49.210368",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# romove ride length is zero or less than zero\n",
    "# romove trips that have no start or end station names\n",
    "all_trips_v2 <- all_trips[!(all_trips$ride_length <= 0|all_trips$start_station_name == \"\"|all_trips$end_station_name == \"\"),]"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "088fd1b6",
   "metadata": {
    "papermill": {
     "duration": 0.164615,
     "end_time": "2022-03-29T18:37:54.543686",
     "exception": false,
     "start_time": "2022-03-29T18:37:54.379071",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**ANALYZE**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "6ffa2ce1",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:37:54.875250Z",
     "iopub.status.busy": "2022-03-29T18:37:54.873345Z",
     "iopub.status.idle": "2022-03-29T18:37:55.095002Z",
     "shell.execute_reply": "2022-03-29T18:37:55.093123Z"
    },
    "papermill": {
     "duration": 0.389316,
     "end_time": "2022-03-29T18:37:55.095150",
     "exception": false,
     "start_time": "2022-03-29T18:37:54.705834",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "21.811924784181"
      ],
      "text/latex": [
       "21.811924784181"
      ],
      "text/markdown": [
       "21.811924784181"
      ],
      "text/plain": [
       "[1] 21.81192"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "12.2"
      ],
      "text/latex": [
       "12.2"
      ],
      "text/markdown": [
       "12.2"
      ],
      "text/plain": [
       "[1] 12.2"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "55944.15"
      ],
      "text/latex": [
       "55944.15"
      ],
      "text/markdown": [
       "55944.15"
      ],
      "text/plain": [
       "[1] 55944.15"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0.0166666666666667"
      ],
      "text/latex": [
       "0.0166666666666667"
      ],
      "text/markdown": [
       "0.0166666666666667"
      ],
      "text/plain": [
       "[1] 0.01666667"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# create summary data frame (all figures in minutes)\n",
    "mean(all_trips_v2$ride_length)\n",
    "median(all_trips_v2$ride_length)\n",
    "max(all_trips_v2$ride_length)\n",
    "min(all_trips_v2$ride_length)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "a6ef0782",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:37:55.451211Z",
     "iopub.status.busy": "2022-03-29T18:37:55.449324Z",
     "iopub.status.idle": "2022-03-29T18:38:15.267549Z",
     "shell.execute_reply": "2022-03-29T18:38:15.265830Z"
    },
    "papermill": {
     "duration": 19.996847,
     "end_time": "2022-03-29T18:38:15.267693",
     "exception": false,
     "start_time": "2022-03-29T18:37:55.270846",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>32.51015</td></tr>\n",
       "\t<tr><td>member</td><td>13.18401</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 32.51015\\\\\n",
       "\t member & 13.18401\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 2\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| casual | 32.51015 |\n",
       "| member | 13.18401 |\n",
       "\n"
      ],
      "text/plain": [
       "  all_trips_v2$member_casual all_trips_v2$ride_length\n",
       "1 casual                     32.51015                \n",
       "2 member                     13.18401                "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>16.650000</td></tr>\n",
       "\t<tr><td>member</td><td> 9.716667</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 16.650000\\\\\n",
       "\t member &  9.716667\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 2\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| casual | 16.650000 |\n",
       "| member |  9.716667 |\n",
       "\n"
      ],
      "text/plain": [
       "  all_trips_v2$member_casual all_trips_v2$ride_length\n",
       "1 casual                     16.650000               \n",
       "2 member                      9.716667               "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>55944.150</td></tr>\n",
       "\t<tr><td>member</td><td> 1495.633</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 55944.150\\\\\n",
       "\t member &  1495.633\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 2\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| casual | 55944.150 |\n",
       "| member |  1495.633 |\n",
       "\n"
      ],
      "text/plain": [
       "  all_trips_v2$member_casual all_trips_v2$ride_length\n",
       "1 casual                     55944.150               \n",
       "2 member                      1495.633               "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>0.01666667</td></tr>\n",
       "\t<tr><td>member</td><td>0.01666667</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 0.01666667\\\\\n",
       "\t member & 0.01666667\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 2\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| casual | 0.01666667 |\n",
       "| member | 0.01666667 |\n",
       "\n"
      ],
      "text/plain": [
       "  all_trips_v2$member_casual all_trips_v2$ride_length\n",
       "1 casual                     0.01666667              \n",
       "2 member                     0.01666667              "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#compare ride length between members and casual riders\n",
    "aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual,FUN=mean)\n",
    "aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual,FUN=median)\n",
    "aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual,FUN=max)\n",
    "aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual,FUN=min)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "16d82c88",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:38:15.643020Z",
     "iopub.status.busy": "2022-03-29T18:38:15.641064Z",
     "iopub.status.idle": "2022-03-29T18:38:20.177448Z",
     "shell.execute_reply": "2022-03-29T18:38:20.175700Z"
    },
    "papermill": {
     "duration": 4.725964,
     "end_time": "2022-03-29T18:38:20.177594",
     "exception": false,
     "start_time": "2022-03-29T18:38:15.451630",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 14 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$day_of_week</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>Sunday   </td><td>37.60361</td></tr>\n",
       "\t<tr><td>member</td><td>Sunday   </td><td>15.19465</td></tr>\n",
       "\t<tr><td>casual</td><td>Monday   </td><td>32.63724</td></tr>\n",
       "\t<tr><td>member</td><td>Monday   </td><td>12.72520</td></tr>\n",
       "\t<tr><td>casual</td><td>Tuesday  </td><td>28.80335</td></tr>\n",
       "\t<tr><td>member</td><td>Tuesday  </td><td>12.38802</td></tr>\n",
       "\t<tr><td>casual</td><td>Wednesday</td><td>28.26964</td></tr>\n",
       "\t<tr><td>member</td><td>Wednesday</td><td>12.45815</td></tr>\n",
       "\t<tr><td>casual</td><td>Thursday </td><td>28.01100</td></tr>\n",
       "\t<tr><td>member</td><td>Thursday </td><td>12.35370</td></tr>\n",
       "\t<tr><td>casual</td><td>Friday   </td><td>30.91907</td></tr>\n",
       "\t<tr><td>member</td><td>Friday   </td><td>12.79261</td></tr>\n",
       "\t<tr><td>casual</td><td>Saturday </td><td>34.87241</td></tr>\n",
       "\t<tr><td>member</td><td>Saturday </td><td>14.81979</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 14 × 3\n",
       "\\begin{tabular}{lll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$day\\_of\\_week & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <ord> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & Sunday    & 37.60361\\\\\n",
       "\t member & Sunday    & 15.19465\\\\\n",
       "\t casual & Monday    & 32.63724\\\\\n",
       "\t member & Monday    & 12.72520\\\\\n",
       "\t casual & Tuesday   & 28.80335\\\\\n",
       "\t member & Tuesday   & 12.38802\\\\\n",
       "\t casual & Wednesday & 28.26964\\\\\n",
       "\t member & Wednesday & 12.45815\\\\\n",
       "\t casual & Thursday  & 28.01100\\\\\n",
       "\t member & Thursday  & 12.35370\\\\\n",
       "\t casual & Friday    & 30.91907\\\\\n",
       "\t member & Friday    & 12.79261\\\\\n",
       "\t casual & Saturday  & 34.87241\\\\\n",
       "\t member & Saturday  & 14.81979\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 14 × 3\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$day_of_week &lt;ord&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| casual | Sunday    | 37.60361 |\n",
       "| member | Sunday    | 15.19465 |\n",
       "| casual | Monday    | 32.63724 |\n",
       "| member | Monday    | 12.72520 |\n",
       "| casual | Tuesday   | 28.80335 |\n",
       "| member | Tuesday   | 12.38802 |\n",
       "| casual | Wednesday | 28.26964 |\n",
       "| member | Wednesday | 12.45815 |\n",
       "| casual | Thursday  | 28.01100 |\n",
       "| member | Thursday  | 12.35370 |\n",
       "| casual | Friday    | 30.91907 |\n",
       "| member | Friday    | 12.79261 |\n",
       "| casual | Saturday  | 34.87241 |\n",
       "| member | Saturday  | 14.81979 |\n",
       "\n"
      ],
      "text/plain": [
       "   all_trips_v2$member_casual all_trips_v2$day_of_week all_trips_v2$ride_length\n",
       "1  casual                     Sunday                   37.60361                \n",
       "2  member                     Sunday                   15.19465                \n",
       "3  casual                     Monday                   32.63724                \n",
       "4  member                     Monday                   12.72520                \n",
       "5  casual                     Tuesday                  28.80335                \n",
       "6  member                     Tuesday                  12.38802                \n",
       "7  casual                     Wednesday                28.26964                \n",
       "8  member                     Wednesday                12.45815                \n",
       "9  casual                     Thursday                 28.01100                \n",
       "10 member                     Thursday                 12.35370                \n",
       "11 casual                     Friday                   30.91907                \n",
       "12 member                     Friday                   12.79261                \n",
       "13 casual                     Saturday                 34.87241                \n",
       "14 member                     Saturday                 14.81979                "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# put day of week in order\n",
    "all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week,levels=c(\"Sunday\",\"Monday\",\"Tuesday\",\"Wednesday\",\"Thursday\",\"Friday\",\"Saturday\"))\n",
    "\n",
    "# average ride time by each day for members vs casual users\n",
    "aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week,FUN=mean)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "6b6e895e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:38:20.593020Z",
     "iopub.status.busy": "2022-03-29T18:38:20.591382Z",
     "iopub.status.idle": "2022-03-29T18:38:26.053369Z",
     "shell.execute_reply": "2022-03-29T18:38:26.052031Z"
    },
    "papermill": {
     "duration": 5.667499,
     "end_time": "2022-03-29T18:38:26.053508",
     "exception": false,
     "start_time": "2022-03-29T18:38:20.386009",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 24 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$month</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>01</td><td>26.37000</td></tr>\n",
       "\t<tr><td>member</td><td>01</td><td>12.03113</td></tr>\n",
       "\t<tr><td>casual</td><td>02</td><td>47.13712</td></tr>\n",
       "\t<tr><td>member</td><td>02</td><td>14.78120</td></tr>\n",
       "\t<tr><td>casual</td><td>03</td><td>38.48048</td></tr>\n",
       "\t<tr><td>member</td><td>03</td><td>13.66530</td></tr>\n",
       "\t<tr><td>casual</td><td>04</td><td>38.44172</td></tr>\n",
       "\t<tr><td>member</td><td>04</td><td>14.26311</td></tr>\n",
       "\t<tr><td>casual</td><td>05</td><td>39.63541</td></tr>\n",
       "\t<tr><td>member</td><td>05</td><td>14.34406</td></tr>\n",
       "\t<tr><td>casual</td><td>06</td><td>38.52029</td></tr>\n",
       "\t<tr><td>member</td><td>06</td><td>14.14005</td></tr>\n",
       "\t<tr><td>casual</td><td>07</td><td>33.28582</td></tr>\n",
       "\t<tr><td>member</td><td>07</td><td>13.79144</td></tr>\n",
       "\t<tr><td>casual</td><td>08</td><td>28.56455</td></tr>\n",
       "\t<tr><td>member</td><td>08</td><td>13.55293</td></tr>\n",
       "\t<tr><td>casual</td><td>09</td><td>28.08851</td></tr>\n",
       "\t<tr><td>member</td><td>09</td><td>13.13137</td></tr>\n",
       "\t<tr><td>casual</td><td>10</td><td>26.31429</td></tr>\n",
       "\t<tr><td>member</td><td>10</td><td>12.01463</td></tr>\n",
       "\t<tr><td>casual</td><td>11</td><td>22.48274</td></tr>\n",
       "\t<tr><td>member</td><td>11</td><td>10.95157</td></tr>\n",
       "\t<tr><td>casual</td><td>12</td><td>24.84308</td></tr>\n",
       "\t<tr><td>member</td><td>12</td><td>10.58142</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 24 × 3\n",
       "\\begin{tabular}{lll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$month & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <ord> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 01 & 26.37000\\\\\n",
       "\t member & 01 & 12.03113\\\\\n",
       "\t casual & 02 & 47.13712\\\\\n",
       "\t member & 02 & 14.78120\\\\\n",
       "\t casual & 03 & 38.48048\\\\\n",
       "\t member & 03 & 13.66530\\\\\n",
       "\t casual & 04 & 38.44172\\\\\n",
       "\t member & 04 & 14.26311\\\\\n",
       "\t casual & 05 & 39.63541\\\\\n",
       "\t member & 05 & 14.34406\\\\\n",
       "\t casual & 06 & 38.52029\\\\\n",
       "\t member & 06 & 14.14005\\\\\n",
       "\t casual & 07 & 33.28582\\\\\n",
       "\t member & 07 & 13.79144\\\\\n",
       "\t casual & 08 & 28.56455\\\\\n",
       "\t member & 08 & 13.55293\\\\\n",
       "\t casual & 09 & 28.08851\\\\\n",
       "\t member & 09 & 13.13137\\\\\n",
       "\t casual & 10 & 26.31429\\\\\n",
       "\t member & 10 & 12.01463\\\\\n",
       "\t casual & 11 & 22.48274\\\\\n",
       "\t member & 11 & 10.95157\\\\\n",
       "\t casual & 12 & 24.84308\\\\\n",
       "\t member & 12 & 10.58142\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 24 × 3\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$month &lt;ord&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| casual | 01 | 26.37000 |\n",
       "| member | 01 | 12.03113 |\n",
       "| casual | 02 | 47.13712 |\n",
       "| member | 02 | 14.78120 |\n",
       "| casual | 03 | 38.48048 |\n",
       "| member | 03 | 13.66530 |\n",
       "| casual | 04 | 38.44172 |\n",
       "| member | 04 | 14.26311 |\n",
       "| casual | 05 | 39.63541 |\n",
       "| member | 05 | 14.34406 |\n",
       "| casual | 06 | 38.52029 |\n",
       "| member | 06 | 14.14005 |\n",
       "| casual | 07 | 33.28582 |\n",
       "| member | 07 | 13.79144 |\n",
       "| casual | 08 | 28.56455 |\n",
       "| member | 08 | 13.55293 |\n",
       "| casual | 09 | 28.08851 |\n",
       "| member | 09 | 13.13137 |\n",
       "| casual | 10 | 26.31429 |\n",
       "| member | 10 | 12.01463 |\n",
       "| casual | 11 | 22.48274 |\n",
       "| member | 11 | 10.95157 |\n",
       "| casual | 12 | 24.84308 |\n",
       "| member | 12 | 10.58142 |\n",
       "\n"
      ],
      "text/plain": [
       "   all_trips_v2$member_casual all_trips_v2$month all_trips_v2$ride_length\n",
       "1  casual                     01                 26.37000                \n",
       "2  member                     01                 12.03113                \n",
       "3  casual                     02                 47.13712                \n",
       "4  member                     02                 14.78120                \n",
       "5  casual                     03                 38.48048                \n",
       "6  member                     03                 13.66530                \n",
       "7  casual                     04                 38.44172                \n",
       "8  member                     04                 14.26311                \n",
       "9  casual                     05                 39.63541                \n",
       "10 member                     05                 14.34406                \n",
       "11 casual                     06                 38.52029                \n",
       "12 member                     06                 14.14005                \n",
       "13 casual                     07                 33.28582                \n",
       "14 member                     07                 13.79144                \n",
       "15 casual                     08                 28.56455                \n",
       "16 member                     08                 13.55293                \n",
       "17 casual                     09                 28.08851                \n",
       "18 member                     09                 13.13137                \n",
       "19 casual                     10                 26.31429                \n",
       "20 member                     10                 12.01463                \n",
       "21 casual                     11                 22.48274                \n",
       "22 member                     11                 10.95157                \n",
       "23 casual                     12                 24.84308                \n",
       "24 member                     12                 10.58142                "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# put month in order\n",
    "all_trips_v2$month <- ordered(all_trips_v2$month,levels = c(\"01\",\"02\",\"03\",\"04\",\"05\",\"06\",\"07\",\"08\",\"09\",\"10\",\"11\",\"12\"))\n",
    "\n",
    "# average ride length by month between members and casual riders\n",
    "aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$month, FUN=mean)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "47c95a09",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:38:26.446788Z",
     "iopub.status.busy": "2022-03-29T18:38:26.445328Z",
     "iopub.status.idle": "2022-03-29T18:38:26.695360Z",
     "shell.execute_reply": "2022-03-29T18:38:26.693850Z"
    },
    "papermill": {
     "duration": 0.449403,
     "end_time": "2022-03-29T18:38:26.695496",
     "exception": false,
     "start_time": "2022-03-29T18:38:26.246093",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 24 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>member_casual</th><th scope=col>month</th><th scope=col>number_of_rides</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>01</td><td> 14690</td></tr>\n",
       "\t<tr><td>member</td><td>01</td><td> 68818</td></tr>\n",
       "\t<tr><td>casual</td><td>02</td><td>  8613</td></tr>\n",
       "\t<tr><td>member</td><td>02</td><td> 34381</td></tr>\n",
       "\t<tr><td>casual</td><td>03</td><td> 75641</td></tr>\n",
       "\t<tr><td>member</td><td>03</td><td>130046</td></tr>\n",
       "\t<tr><td>casual</td><td>04</td><td>120418</td></tr>\n",
       "\t<tr><td>member</td><td>04</td><td>177781</td></tr>\n",
       "\t<tr><td>casual</td><td>05</td><td>216823</td></tr>\n",
       "\t<tr><td>member</td><td>05</td><td>234155</td></tr>\n",
       "\t<tr><td>casual</td><td>06</td><td>304184</td></tr>\n",
       "\t<tr><td>member</td><td>06</td><td>304579</td></tr>\n",
       "\t<tr><td>casual</td><td>07</td><td>369401</td></tr>\n",
       "\t<tr><td>member</td><td>07</td><td>322892</td></tr>\n",
       "\t<tr><td>casual</td><td>08</td><td>341463</td></tr>\n",
       "\t<tr><td>member</td><td>08</td><td>332914</td></tr>\n",
       "\t<tr><td>casual</td><td>09</td><td>292920</td></tr>\n",
       "\t<tr><td>member</td><td>09</td><td>328183</td></tr>\n",
       "\t<tr><td>casual</td><td>10</td><td>189115</td></tr>\n",
       "\t<tr><td>member</td><td>10</td><td>288851</td></tr>\n",
       "\t<tr><td>casual</td><td>11</td><td> 69958</td></tr>\n",
       "\t<tr><td>member</td><td>11</td><td>185909</td></tr>\n",
       "\t<tr><td>casual</td><td>12</td><td> 45076</td></tr>\n",
       "\t<tr><td>member</td><td>12</td><td>131293</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 24 × 3\n",
       "\\begin{tabular}{lll}\n",
       " member\\_casual & month & number\\_of\\_rides\\\\\n",
       " <chr> & <ord> & <int>\\\\\n",
       "\\hline\n",
       "\t casual & 01 &  14690\\\\\n",
       "\t member & 01 &  68818\\\\\n",
       "\t casual & 02 &   8613\\\\\n",
       "\t member & 02 &  34381\\\\\n",
       "\t casual & 03 &  75641\\\\\n",
       "\t member & 03 & 130046\\\\\n",
       "\t casual & 04 & 120418\\\\\n",
       "\t member & 04 & 177781\\\\\n",
       "\t casual & 05 & 216823\\\\\n",
       "\t member & 05 & 234155\\\\\n",
       "\t casual & 06 & 304184\\\\\n",
       "\t member & 06 & 304579\\\\\n",
       "\t casual & 07 & 369401\\\\\n",
       "\t member & 07 & 322892\\\\\n",
       "\t casual & 08 & 341463\\\\\n",
       "\t member & 08 & 332914\\\\\n",
       "\t casual & 09 & 292920\\\\\n",
       "\t member & 09 & 328183\\\\\n",
       "\t casual & 10 & 189115\\\\\n",
       "\t member & 10 & 288851\\\\\n",
       "\t casual & 11 &  69958\\\\\n",
       "\t member & 11 & 185909\\\\\n",
       "\t casual & 12 &  45076\\\\\n",
       "\t member & 12 & 131293\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 24 × 3\n",
       "\n",
       "| member_casual &lt;chr&gt; | month &lt;ord&gt; | number_of_rides &lt;int&gt; |\n",
       "|---|---|---|\n",
       "| casual | 01 |  14690 |\n",
       "| member | 01 |  68818 |\n",
       "| casual | 02 |   8613 |\n",
       "| member | 02 |  34381 |\n",
       "| casual | 03 |  75641 |\n",
       "| member | 03 | 130046 |\n",
       "| casual | 04 | 120418 |\n",
       "| member | 04 | 177781 |\n",
       "| casual | 05 | 216823 |\n",
       "| member | 05 | 234155 |\n",
       "| casual | 06 | 304184 |\n",
       "| member | 06 | 304579 |\n",
       "| casual | 07 | 369401 |\n",
       "| member | 07 | 322892 |\n",
       "| casual | 08 | 341463 |\n",
       "| member | 08 | 332914 |\n",
       "| casual | 09 | 292920 |\n",
       "| member | 09 | 328183 |\n",
       "| casual | 10 | 189115 |\n",
       "| member | 10 | 288851 |\n",
       "| casual | 11 |  69958 |\n",
       "| member | 11 | 185909 |\n",
       "| casual | 12 |  45076 |\n",
       "| member | 12 | 131293 |\n",
       "\n"
      ],
      "text/plain": [
       "   member_casual month number_of_rides\n",
       "1  casual        01     14690         \n",
       "2  member        01     68818         \n",
       "3  casual        02      8613         \n",
       "4  member        02     34381         \n",
       "5  casual        03     75641         \n",
       "6  member        03    130046         \n",
       "7  casual        04    120418         \n",
       "8  member        04    177781         \n",
       "9  casual        05    216823         \n",
       "10 member        05    234155         \n",
       "11 casual        06    304184         \n",
       "12 member        06    304579         \n",
       "13 casual        07    369401         \n",
       "14 member        07    322892         \n",
       "15 casual        08    341463         \n",
       "16 member        08    332914         \n",
       "17 casual        09    292920         \n",
       "18 member        09    328183         \n",
       "19 casual        10    189115         \n",
       "20 member        10    288851         \n",
       "21 casual        11     69958         \n",
       "22 member        11    185909         \n",
       "23 casual        12     45076         \n",
       "24 member        12    131293         "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# number of rides for each month between members and casual riders\n",
    "all_trips_v2 %>%\n",
    "  group_by(member_casual,month) %>%\n",
    "  summarise(number_of_rides=n(),.groups='drop') %>%\n",
    "  arrange(month)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "9806cc58",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:38:27.091489Z",
     "iopub.status.busy": "2022-03-29T18:38:27.089877Z",
     "iopub.status.idle": "2022-03-29T18:38:39.970209Z",
     "shell.execute_reply": "2022-03-29T18:38:39.968735Z"
    },
    "papermill": {
     "duration": 13.080803,
     "end_time": "2022-03-29T18:38:39.970390",
     "exception": false,
     "start_time": "2022-03-29T18:38:26.889587",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 14 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>member_casual</th><th scope=col>weekday</th><th scope=col>number_of_rides</th><th scope=col>average_duration</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>Sun</td><td>403754</td><td>37.60361</td></tr>\n",
       "\t<tr><td>casual</td><td>Mon</td><td>228931</td><td>32.63724</td></tr>\n",
       "\t<tr><td>casual</td><td>Tue</td><td>214932</td><td>28.80335</td></tr>\n",
       "\t<tr><td>casual</td><td>Wed</td><td>218129</td><td>28.26964</td></tr>\n",
       "\t<tr><td>casual</td><td>Thu</td><td>224204</td><td>28.01100</td></tr>\n",
       "\t<tr><td>casual</td><td>Fri</td><td>290034</td><td>30.91907</td></tr>\n",
       "\t<tr><td>casual</td><td>Sat</td><td>468318</td><td>34.87241</td></tr>\n",
       "\t<tr><td>member</td><td>Sun</td><td>311212</td><td>15.19465</td></tr>\n",
       "\t<tr><td>member</td><td>Mon</td><td>346476</td><td>12.72520</td></tr>\n",
       "\t<tr><td>member</td><td>Tue</td><td>388120</td><td>12.38802</td></tr>\n",
       "\t<tr><td>member</td><td>Wed</td><td>397681</td><td>12.45815</td></tr>\n",
       "\t<tr><td>member</td><td>Thu</td><td>373469</td><td>12.35370</td></tr>\n",
       "\t<tr><td>member</td><td>Fri</td><td>365774</td><td>12.79261</td></tr>\n",
       "\t<tr><td>member</td><td>Sat</td><td>357070</td><td>14.81979</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 14 × 4\n",
       "\\begin{tabular}{llll}\n",
       " member\\_casual & weekday & number\\_of\\_rides & average\\_duration\\\\\n",
       " <chr> & <ord> & <int> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & Sun & 403754 & 37.60361\\\\\n",
       "\t casual & Mon & 228931 & 32.63724\\\\\n",
       "\t casual & Tue & 214932 & 28.80335\\\\\n",
       "\t casual & Wed & 218129 & 28.26964\\\\\n",
       "\t casual & Thu & 224204 & 28.01100\\\\\n",
       "\t casual & Fri & 290034 & 30.91907\\\\\n",
       "\t casual & Sat & 468318 & 34.87241\\\\\n",
       "\t member & Sun & 311212 & 15.19465\\\\\n",
       "\t member & Mon & 346476 & 12.72520\\\\\n",
       "\t member & Tue & 388120 & 12.38802\\\\\n",
       "\t member & Wed & 397681 & 12.45815\\\\\n",
       "\t member & Thu & 373469 & 12.35370\\\\\n",
       "\t member & Fri & 365774 & 12.79261\\\\\n",
       "\t member & Sat & 357070 & 14.81979\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 14 × 4\n",
       "\n",
       "| member_casual &lt;chr&gt; | weekday &lt;ord&gt; | number_of_rides &lt;int&gt; | average_duration &lt;dbl&gt; |\n",
       "|---|---|---|---|\n",
       "| casual | Sun | 403754 | 37.60361 |\n",
       "| casual | Mon | 228931 | 32.63724 |\n",
       "| casual | Tue | 214932 | 28.80335 |\n",
       "| casual | Wed | 218129 | 28.26964 |\n",
       "| casual | Thu | 224204 | 28.01100 |\n",
       "| casual | Fri | 290034 | 30.91907 |\n",
       "| casual | Sat | 468318 | 34.87241 |\n",
       "| member | Sun | 311212 | 15.19465 |\n",
       "| member | Mon | 346476 | 12.72520 |\n",
       "| member | Tue | 388120 | 12.38802 |\n",
       "| member | Wed | 397681 | 12.45815 |\n",
       "| member | Thu | 373469 | 12.35370 |\n",
       "| member | Fri | 365774 | 12.79261 |\n",
       "| member | Sat | 357070 | 14.81979 |\n",
       "\n"
      ],
      "text/plain": [
       "   member_casual weekday number_of_rides average_duration\n",
       "1  casual        Sun     403754          37.60361        \n",
       "2  casual        Mon     228931          32.63724        \n",
       "3  casual        Tue     214932          28.80335        \n",
       "4  casual        Wed     218129          28.26964        \n",
       "5  casual        Thu     224204          28.01100        \n",
       "6  casual        Fri     290034          30.91907        \n",
       "7  casual        Sat     468318          34.87241        \n",
       "8  member        Sun     311212          15.19465        \n",
       "9  member        Mon     346476          12.72520        \n",
       "10 member        Tue     388120          12.38802        \n",
       "11 member        Wed     397681          12.45815        \n",
       "12 member        Thu     373469          12.35370        \n",
       "13 member        Fri     365774          12.79261        \n",
       "14 member        Sat     357070          14.81979        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# analyze ridership data by types and weekdays\n",
    "all_trips_v2 %>%\n",
    " mutate(weekday=wday(started_at,label=TRUE)) %>% # create weekday field by using wday()\n",
    " group_by(member_casual,weekday) %>% # group by user type and weekday\n",
    " summarise(number_of_rides=n(),average_duration=mean(ride_length),.groups='drop') %>% # calculate number of rides and average duration\n",
    " arrange(member_casual,weekday)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "7e8d6d81",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:38:40.371193Z",
     "iopub.status.busy": "2022-03-29T18:38:40.369713Z",
     "iopub.status.idle": "2022-03-29T18:38:40.617547Z",
     "shell.execute_reply": "2022-03-29T18:38:40.616098Z"
    },
    "papermill": {
     "duration": 0.448858,
     "end_time": "2022-03-29T18:38:40.617679",
     "exception": false,
     "start_time": "2022-03-29T18:38:40.168821",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 20 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>start_station_name</th><th scope=col>member_casual</th><th scope=col>number_of_rides</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Streeter Dr &amp; Grand Ave           </span></td><td>casual</td><td>64446</td></tr>\n",
       "\t<tr><td>Millennium Park                   </td><td>casual</td><td>32185</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Michigan Ave &amp; Oak St             </span></td><td>casual</td><td>28661</td></tr>\n",
       "\t<tr><td>Shedd Aquarium                    </td><td>casual</td><td>22544</td></tr>\n",
       "\t<tr><td>Theater on the Lake               </td><td>casual</td><td>20620</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Lake Shore Dr &amp; Monroe St         </span></td><td>casual</td><td>19085</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Wells St &amp; Concord Ln             </span></td><td>casual</td><td>18879</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Clark St &amp; Lincoln Ave            </span></td><td>casual</td><td>16290</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Indiana Ave &amp; Roosevelt Rd        </span></td><td>casual</td><td>15814</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Wells St &amp; Elm St                 </span></td><td>casual</td><td>15809</td></tr>\n",
       "\t<tr><td>DuSable Lake Shore Dr &amp; Monroe St </td><td>casual</td><td>15671</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Clark St &amp; Elm St                 </span></td><td>casual</td><td>15597</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Clark St &amp; Armitage Ave           </span></td><td>casual</td><td>15399</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Wabash Ave &amp; Grand Ave            </span></td><td>casual</td><td>15376</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>New St &amp; Illinois St              </span></td><td>casual</td><td>14709</td></tr>\n",
       "\t<tr><td>Dusable Harbor                    </td><td>casual</td><td>14698</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Lake Shore Dr &amp; North Blvd        </span></td><td>casual</td><td>14380</td></tr>\n",
       "\t<tr><td>DuSable Lake Shore Dr &amp; North Blvd</td><td>casual</td><td>14304</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Michigan Ave &amp; Lake St            </span></td><td>casual</td><td>14002</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Michigan Ave &amp; Washington St      </span></td><td>casual</td><td>13677</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 20 × 3\n",
       "\\begin{tabular}{lll}\n",
       " start\\_station\\_name & member\\_casual & number\\_of\\_rides\\\\\n",
       " <chr> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t Streeter Dr \\& Grand Ave            & casual & 64446\\\\\n",
       "\t Millennium Park                    & casual & 32185\\\\\n",
       "\t Michigan Ave \\& Oak St              & casual & 28661\\\\\n",
       "\t Shedd Aquarium                     & casual & 22544\\\\\n",
       "\t Theater on the Lake                & casual & 20620\\\\\n",
       "\t Lake Shore Dr \\& Monroe St          & casual & 19085\\\\\n",
       "\t Wells St \\& Concord Ln              & casual & 18879\\\\\n",
       "\t Clark St \\& Lincoln Ave             & casual & 16290\\\\\n",
       "\t Indiana Ave \\& Roosevelt Rd         & casual & 15814\\\\\n",
       "\t Wells St \\& Elm St                  & casual & 15809\\\\\n",
       "\t DuSable Lake Shore Dr \\& Monroe St  & casual & 15671\\\\\n",
       "\t Clark St \\& Elm St                  & casual & 15597\\\\\n",
       "\t Clark St \\& Armitage Ave            & casual & 15399\\\\\n",
       "\t Wabash Ave \\& Grand Ave             & casual & 15376\\\\\n",
       "\t New St \\& Illinois St               & casual & 14709\\\\\n",
       "\t Dusable Harbor                     & casual & 14698\\\\\n",
       "\t Lake Shore Dr \\& North Blvd         & casual & 14380\\\\\n",
       "\t DuSable Lake Shore Dr \\& North Blvd & casual & 14304\\\\\n",
       "\t Michigan Ave \\& Lake St             & casual & 14002\\\\\n",
       "\t Michigan Ave \\& Washington St       & casual & 13677\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 20 × 3\n",
       "\n",
       "| start_station_name &lt;chr&gt; | member_casual &lt;chr&gt; | number_of_rides &lt;int&gt; |\n",
       "|---|---|---|\n",
       "| Streeter Dr &amp; Grand Ave            | casual | 64446 |\n",
       "| Millennium Park                    | casual | 32185 |\n",
       "| Michigan Ave &amp; Oak St              | casual | 28661 |\n",
       "| Shedd Aquarium                     | casual | 22544 |\n",
       "| Theater on the Lake                | casual | 20620 |\n",
       "| Lake Shore Dr &amp; Monroe St          | casual | 19085 |\n",
       "| Wells St &amp; Concord Ln              | casual | 18879 |\n",
       "| Clark St &amp; Lincoln Ave             | casual | 16290 |\n",
       "| Indiana Ave &amp; Roosevelt Rd         | casual | 15814 |\n",
       "| Wells St &amp; Elm St                  | casual | 15809 |\n",
       "| DuSable Lake Shore Dr &amp; Monroe St  | casual | 15671 |\n",
       "| Clark St &amp; Elm St                  | casual | 15597 |\n",
       "| Clark St &amp; Armitage Ave            | casual | 15399 |\n",
       "| Wabash Ave &amp; Grand Ave             | casual | 15376 |\n",
       "| New St &amp; Illinois St               | casual | 14709 |\n",
       "| Dusable Harbor                     | casual | 14698 |\n",
       "| Lake Shore Dr &amp; North Blvd         | casual | 14380 |\n",
       "| DuSable Lake Shore Dr &amp; North Blvd | casual | 14304 |\n",
       "| Michigan Ave &amp; Lake St             | casual | 14002 |\n",
       "| Michigan Ave &amp; Washington St       | casual | 13677 |\n",
       "\n"
      ],
      "text/plain": [
       "   start_station_name                 member_casual number_of_rides\n",
       "1  Streeter Dr & Grand Ave            casual        64446          \n",
       "2  Millennium Park                    casual        32185          \n",
       "3  Michigan Ave & Oak St              casual        28661          \n",
       "4  Shedd Aquarium                     casual        22544          \n",
       "5  Theater on the Lake                casual        20620          \n",
       "6  Lake Shore Dr & Monroe St          casual        19085          \n",
       "7  Wells St & Concord Ln              casual        18879          \n",
       "8  Clark St & Lincoln Ave             casual        16290          \n",
       "9  Indiana Ave & Roosevelt Rd         casual        15814          \n",
       "10 Wells St & Elm St                  casual        15809          \n",
       "11 DuSable Lake Shore Dr & Monroe St  casual        15671          \n",
       "12 Clark St & Elm St                  casual        15597          \n",
       "13 Clark St & Armitage Ave            casual        15399          \n",
       "14 Wabash Ave & Grand Ave             casual        15376          \n",
       "15 New St & Illinois St               casual        14709          \n",
       "16 Dusable Harbor                     casual        14698          \n",
       "17 Lake Shore Dr & North Blvd         casual        14380          \n",
       "18 DuSable Lake Shore Dr & North Blvd casual        14304          \n",
       "19 Michigan Ave & Lake St             casual        14002          \n",
       "20 Michigan Ave & Washington St       casual        13677          "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Top 20 start stations for casual riders\n",
    "all_trips_v2 %>%\n",
    "  group_by(start_station_name, member_casual) %>%\n",
    "  summarise(number_of_rides=n(),.groups='drop') %>%\n",
    "  filter(start_station_name != \"\",member_casual != \"member\") %>%\n",
    "  arrange(desc(number_of_rides)) %>%\n",
    "  head(n=20)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "id": "6d9e0151",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:38:41.047149Z",
     "iopub.status.busy": "2022-03-29T18:38:41.045521Z",
     "iopub.status.idle": "2022-03-29T18:38:41.217875Z",
     "shell.execute_reply": "2022-03-29T18:38:41.216303Z"
    },
    "papermill": {
     "duration": 0.380211,
     "end_time": "2022-03-29T18:38:41.218036",
     "exception": false,
     "start_time": "2022-03-29T18:38:40.837825",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>rideable_type</th><th scope=col>member_casual</th><th scope=col>number_of_rides</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>classic_bike </td><td>casual</td><td>1261508</td></tr>\n",
       "\t<tr><td>classic_bike </td><td>member</td><td>1980328</td></tr>\n",
       "\t<tr><td>docked_bike  </td><td>casual</td><td> 312040</td></tr>\n",
       "\t<tr><td>docked_bike  </td><td>member</td><td>      1</td></tr>\n",
       "\t<tr><td>electric_bike</td><td>casual</td><td> 474754</td></tr>\n",
       "\t<tr><td>electric_bike</td><td>member</td><td> 559473</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 3\n",
       "\\begin{tabular}{lll}\n",
       " rideable\\_type & member\\_casual & number\\_of\\_rides\\\\\n",
       " <chr> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t classic\\_bike  & casual & 1261508\\\\\n",
       "\t classic\\_bike  & member & 1980328\\\\\n",
       "\t docked\\_bike   & casual &  312040\\\\\n",
       "\t docked\\_bike   & member &       1\\\\\n",
       "\t electric\\_bike & casual &  474754\\\\\n",
       "\t electric\\_bike & member &  559473\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 3\n",
       "\n",
       "| rideable_type &lt;chr&gt; | member_casual &lt;chr&gt; | number_of_rides &lt;int&gt; |\n",
       "|---|---|---|\n",
       "| classic_bike  | casual | 1261508 |\n",
       "| classic_bike  | member | 1980328 |\n",
       "| docked_bike   | casual |  312040 |\n",
       "| docked_bike   | member |       1 |\n",
       "| electric_bike | casual |  474754 |\n",
       "| electric_bike | member |  559473 |\n",
       "\n"
      ],
      "text/plain": [
       "  rideable_type member_casual number_of_rides\n",
       "1 classic_bike  casual        1261508        \n",
       "2 classic_bike  member        1980328        \n",
       "3 docked_bike   casual         312040        \n",
       "4 docked_bike   member              1        \n",
       "5 electric_bike casual         474754        \n",
       "6 electric_bike member         559473        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# bike types preference between members and casual riders\n",
    "all_trips_v2 %>%\n",
    "  group_by(rideable_type,member_casual) %>%\n",
    "  summarise(number_of_rides = n(),.groups='drop')"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "cc27033d",
   "metadata": {
    "papermill": {
     "duration": 0.202844,
     "end_time": "2022-03-29T18:38:41.623097",
     "exception": false,
     "start_time": "2022-03-29T18:38:41.420253",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**SHARE**\n",
    "Creating data visualizations"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "id": "d6964e48",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:38:42.030666Z",
     "iopub.status.busy": "2022-03-29T18:38:42.029155Z",
     "iopub.status.idle": "2022-03-29T18:38:59.579881Z",
     "shell.execute_reply": "2022-03-29T18:38:59.579051Z"
    },
    "papermill": {
     "duration": 17.756652,
     "end_time": "2022-03-29T18:38:59.580068",
     "exception": false,
     "start_time": "2022-03-29T18:38:41.823416",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\nnogTHcSxByn2fXPbzjubYrdrvQo0fXNgr5erpu42ZcqUHTt2OG77+/uvW7cu0zkn52C92aDT\n6YKCgpQ9ppup1er8tmQhRD5csr+/v7unoDRfX193T0FpXl5eXl7Zfud0LlD4N7YQwmg0enp6\nKn7Y/xQdHe3uKSBPUCjsvp/+Xmz1ft2fCrZb/z4nZ4retO583JSvB1f20gkhQspVth7ssGrR\nqSaTnvmvcWzmBCFEkPbvE43BOo3lgcmafOOBRlc6uNaHKyb62+MPbl360ZKx+tAvuoQ9/C9K\nUlLS/fv3Hbc1Go1KlRc/k5s3Z+VSLDk/YMn5QT5cssivq0Yep0TY3fl5wbIzhSOWP/+v7Q/+\n+MVut49+4x8vznpZbgh7dZM5RQhhMZmFECaTyfGQ3mBQe3gKIe5ZbN6ah2f+olOsGn8PjUex\nNWvW/DWGvm674ecjj+789GSXj+s4NjVp0iQ0NPThw3p9QkJCptNW+APDVqs1daXS0+l0Hh4e\ndrs9MTHR3XNRiFar1ev1Qghn/u7JQa1WO85nJCUl2Ww2d09HCSqVymg0CiFMJpPVanX3dBTi\nOFFnNpstFosbp6H8tbtSUlKSk5U/UQhkQol/C1E/nkiO/7Pb661St3zX841tXk9+Osmg0nit\nXrks7c4qtS4xamX77qmVJtq2beu4MXvNhqJeVYTYey7JUkL/MOwuJFn86qTzQk94Ic/tMVGp\nd+vVq1evXj3HbZvNFhMTk+m0fZxdX+6w2WxJSUnKHtOdHGGXf5as1+sdYZd/lqzVah1hl38q\nR61WO8LObDanpKS4ezoKcYRdSkqKe//XVOHf2EKIlJSU/PPPGY8RJcIupPPoma8+/B1nt90f\nMnRC7TFT2hQMMgbfFLZDkTHWVkUd78ywL31vZGyddwY37bh5c0chhCXpbOsO/3iPndC/UNQj\n4od9dxq1KCGESEk4fig++bVGhWPPLxgy/fSUhfMKezhepbXtuZnoX72cAqsD8F9Uu/crfMSo\nyuUVPiIA5ClKhJ2hUKmyhR7edrzHzr9UmTKFvYQo2r1a0OcjJht6tg4r5n1829ItZ6LHjyiY\n0Vgqj6Gtw4Ytn7C9yPBKASmbF8wwFmnYubi3sLQLSuw9YsLi/m828FclHd321d4En3HdCTsA\nAJCPuOErxdJqMW6W+ZP5ayM+vJeiK16m6uBpY6p5Z3JV4bLtJvc1z141a1y0SRXyZP3JE3uo\nhRDa4EkL3l8WsWLu5LEmjU+Z0MrDZ00Iz2woAAAAmajs9nx30Tdn32On4HfFCiHUk2fExcUp\neUQ38vT09PLycvIPQg56vd7Hx0cIcffuXXfPRSFarTbg+CmFD+rel2LVanVgYKAQIi4uLv+8\nxy44OFgI8eDBAze/x07Z39hCCOv4D/Lax78cfxbI55S7QDEAAABcirADAACQBGEHAAAgCcIO\nAABAEoQdAACAJAg7AAAASRB2AAAAkiDsAAAAJEHYAQAASIKwAwAAkARhBwAAIAmtuycA5Beq\n3fsVPqJ7vzgVAKA8ztgBAABIgrADAACQBGEHAAAgCcIOAABAEoQdAACAJAg7AAAASRB2AAAA\nkiDsAAAAJEHYAQAASIKwAwAAkARhBwAAIAnCDgAAQBKEHQAAgCQIOwAAAEkQdgAAAJIg7AAA\nACRB2AEAAEiCsAMAAJAEYQcAACAJwg4AAEAShB0AAIAktO6eAABIRbV7v5KHi6pcXsnDAcjj\nOGMHAAAgCcIOAABAEoQdAACAJAg7AAAASRB2AAAAkiDsAAAAJEHYAQAASIKwAwAAkARhBwAA\nIAnCDgAAQBJ8pRgAIEf4FjUg7+CMHQAAgCQIOwAAAEkQdgAAAJIg7AAAACRB2AEAAEiCsAMA\nAJAEYQcAACAJwg4AAEAShB0AAIAkCDsAAABJEHYAAACSIOwAAAAkoXX3BAAAeMwYmrUTh44p\ndrioyuUVOxYed5yxAwAAkARhBwAAIAnCDgAAQBKEHQAAgCQIOwAAAEkQdgAAAJIg7AAAACRB\n2AEAAEiCsAMAAJBEPv3mCZVK5e4p/JtKpcqDs3KR1JXmwyVLf1D3Hp0l5wcsOV12u12BmSDv\ny6dhFxQUlOk+ZgXmkYZWq3VmVjJRq9X5bckKy4c/XpacH6S7ZIV/YyvMmT/lu3fvKjAT5H35\nNOzu3buX6T5GBeaRhsViiY+PV/aYbmMwGDw9PW02W1xcnLvnohAPDw/lD+rM33PX0Wrd8OvF\nvUtWq9V+fn4KH9S9SxZCBAQEKHzEdJes8G9shbn9TxmPkXwadlar1d1T+De73Z4HZ+UiNpvN\ncSMfLllJ7v3xuuX1Mvcu2S2vheWff0SpWDKQAT48AQAAIAnCDgAAQBL59KVYuJ1q936FjxhV\nubzCRwQAQGGcsQMAAJAEYQcAACAJwg4AAEAShB0AAIAkCDsAAABJEHYAAACSIOwAAAAkQdgB\nAABIgrADAACQBGEHAAAgCcIOAABAEoQdAACAJAg7AAAASRB2AAAAkiDsAAAAJEHYAQAASIKw\nAwAAkARhBwAAIAnCDgAAQBKEHQAAgCQIOwAAAEkQdgAAAJIg7AAAACRB2AEAAEiCsAMAAJAE\nYQcAACAJwg4AAEAShB0AAIAkCDsAAABJEHYAAACSIOwAAAAkQdgBAABIgrADAACQBGEHAAAg\nCcIOAABAEoQdAACAJAg7AAAASRB2AAAAkiDsAAAAJEHYAQAASIKwAwAAkARhBwAAIAnCDgAA\nQBKEHQAAgCQIOwAAAEkQdgAAAJIg7AAAACRB2AEAAEiCsAMAAJAEYQcAACAJwg4AAEAShB0A\nAIAktO6eAIQQwtCsndh/SMkjRlUur+ThAACAAjhjBwAAIAnCDgAAQBKEHQAAgCQIOwAAAEkQ\ndgAAAJIg7AAAACRB2AEAAEiCsAMAAJAEYQcAACAJwg4AAEAShB0AAIAkFPqu2OT75z+d+9lP\nv100abxKPlHx9Z79apfyzu5gtt2rFm7Z+8v1eE1Y5We7DOhaxqgVQtw+MKbHtN/S7tdt2ZpW\nQYYczx0AAODxoEzY2RcOHnfEu0a/sd2C1Qm7Vs/7eOiI8l/PC9Zl53zhpXVjZ62+2rFf/24B\nlu8WLxjzbvKKxf3UQsQej/UMenlgj0qpe5by0eXeEgAAAPI6JcLOHLdr553Ed2f0fc5PL4R4\nYuSwb9uPXB2V2K9o1k/a2ZNnrj4T8sbHbRqFCCHKTle16Tx9xY0unYp53Tl9379irVq1KmU6\nBgAAgJSUeI+dWhvcrVu3Gj4eD++rtEIIo0YthLBbYr6J+OCdXl1fb9thwKgPd5y9l/aJdrv5\nypXrabeY4/ZeM1kbNy7muKv3rxPu7XF09y0hxPH75oBwf2vS/Vt3Yu2uXxQAAEBeo8QZO51X\n1Vatqgoh7h0/+Muff/6yY12BSi93KmgUQnw5alBkUqWePQaX8FWdPfDd3JG9rAuXNylqdDzR\naro8aPC0jes/Tx0qOeGEEKKi8e/XWCsYtZEn4kQHcexBin3f3LbzzqbY7VqvAk3fHNjr5aqp\nux0+fPj69YeN6OHh8fzzz7t82XmbweDOdx/qdG54ldy9S9ZqFXo/a1ruXbJGo1H+oO5dskql\nUv6g7l2yW7DkdJlMJgVmgrxP0f/Y3N63M/L3G1evJj33WmkhhCl607rzcVO+HlzZSyeECClX\n2Xqww6pFp5pMeua/RrCZE4QQQdq/TzQG6zSWByZr8o0HGl3p4Fofrpjob48/uHXpR0vG6kO/\n6BLm79ht06ZNkZGRjtsBAQEtWrTIdLbm7C/0MeDtne0PrzyuWHJ+wJLzg3SXzG9swg4OioZd\nWP9RHwmRePNQr/5T3y9ScWCBX+x2++g3Xk+7j5flhrBXN5lThBAWk1mk+cuqNxjUHp5CiHsW\nm/dfJwOiU6wafw+NR7E1a9b8NYa+brvh5yOP7vz0ZJeP6yi0NgAAAHdTIuzu//7jjxf1zZs+\n67hrLPrsy4GG7364pe3lodJ4rV65LO3OKrUuMWpl++6plSbatm3ruDF7zYaiXlWE2HsuyVJC\n/zDsLiRZ/Or4P3rQ8EKe22OiUu9Onjx58uTJjts2m+3u3buZTtsnC0t8/DjzE3AdT09P5Q/q\n3iXr9XrlD+reJbvl1Wf3LlmtVgcGBip8UPcuWQgRHBys8BHTXTK/sQEHJT48kZK055OIWXdT\nbA/v262nEi3GkkZjoabClhgZYzU8pP96yvgFu24ZC3bcvHnz5s2b16+ertYGbP5LGYPG4P9C\nUQ/ND/vuPBw54fih+OTqjQrHnl/wdvd+t5L/OoSw7bmZ6F+xnAKrAwAAyCOUCLuAsF4hHuaR\n0z47evLc72d+XT132PEkfceOZTx8nu5eLeirEZMjfzx65dK5jYtHbjkT3aB2wYzGUnkMbR32\n+/IJ24+e+/PSyaXjZhiLNOxc3Nu3TLugxNsjJiw+fPLchVPHV80evjfBp2d3wg4AAOQjSrxW\notYVmDxz9MLFX8+Y+INF51OydNigD8bVDtALIVqMm2X+ZP7aiA/vpeiKl6k6eNqYat6ZfF6y\nbLvJfc2zV80aF21ShTxZf/LEHmohhDZ40oL3l0WsmDt5rEnjUya08vBZE8IzGwoAAEAmCr0J\nxljs6aETn350u0rj17rPmNZ90n+W1jMs7bVOUp/T+K0hjd/692Z9QKXeo6b2zvlcAQAAHk9K\nvBQLAAAABRB2AAAAkiDsAAAAJEHYAQAASIKwAwAAkARhBwAAIAnCDgAAQBKEHQAAgCTc8C3d\nAACX8vloomLHMgshmrVT7HAAMsYZOwAAAEkQdgAAAJIg7AAAACRB2AEAAEiCsAMAAJAEYQcA\nACAJwg4AAEAShB0AAIAkCDsAAABJEHYAAACSIOwAAAAkQdgBAABIgrADAACQBGEHAAAgCcIO\nAABAEoQdAACAJLIUdrY/L11w3DLdOTx+WL93xnyw7VK8K6YFAACArNI6uV9y3IE367bYfLFw\ncsIpu+XeKxXr/y86SQixaObi5ed+61DS25WTBAAAQOacPWO3qlWbDaeT3xo8QAhx5+ig/0Un\n9dt6/t7lH6vrbg5tt8aVMwQAAIBTnA27qYfulGq5esmk3kKIE5P36v3qzmkW6l+6zpyOZaN/\nm+nKGQIAAMApzobdNbMl+LkSjtufH4oKqjpYI4QQwquMlyXpomvmBgAAgCxwNuxq++pvfHdc\nCGGO3bYyKrH6qOqO7Uc2/aEzhrlqdgAAAHCasx+eeL9LuTqzu77c/aj24JcqbeDUekUspt+X\nzJgxcP+tQg1muHSKAAAAcIazYVdz+s4JN16cumxuisqz68x9Vbx0D25s6js2wrt43a/WvubS\nKQIAAMAZzoadWhs0bvXh0Yl3EzSBfnq1EMIQ0Gzj98893/g5P43KlTMEAACAU5wNO4eLB3as\n/OHAtTsx9T6MaK+76V+8KlUHAACQRzgfdvaFXev0W/6T447xvbnNH8x9Ifzbet3nbV/cT0vd\nAQAAuJuzn4q9uOK1fst/athv9q8Xbji2BIROn9rzuT1L+reMOOuy6QEAAMBZzobd5CHbAiuM\n3D5/YNWyRR1btMawkRH7368StGfCJJdNDwAAAM5yNuy+uZsU0uXNR7e/2rmMKXpLrk4JAAAA\n2eFs2JXUa+Iv3H90+71TcRp90VydEgAAALLD2bAbXaPg7191/vmuKe3GxJs7u66+FBw+wgUT\nAwAAQNY4G3avrf6kpOpa/Seq9Ro6UQhxatXSScO6VAxtes1WZN7atq6cIQAAAJzibNh5Fnjp\n2K+bX39G/enMCUKI3WOHjJ/xlU/NNhuOnXi9iJcLJwgAAADnZOECxb6hzb7e2eyzqMunLt60\naDyLh1Yq7q933cwAAACQJRmF3aZNmzJ49PbN60f/uv3KK6/k3pQAAACQHRmFXatWrZwcxW63\n58ZkAAAAkH0Zhd3u3btTb9tS7rzXocvhpKLdBvRsULOyv8Z04dSBiOnz/izRevfWmS6fJgAA\nADKTUdjVr18/9fau3pUPJ4buvXqwRuDD99U1funVnv26Pl8kvPWYTmc+a+LaaQIAACAzzn4q\ndvjXF0I6LkqtOgetscKs7uUurh7qgokBAAAga5wNu9+TLGqP9HZWC6v5j9ycEQAAALLF2bBr\nW8D4+xcjrpitaTdazddGf3bBWLC9CyYGAACArHE27MZEvGmO3fNk5Wazv9zw87EzZ44f3LRi\n7ktVqm6/Z3pj0UiXThEAAADOcPYCxSVbLt45W9t2+OJ3O29L3ajxKNB39o4FLUu6Zm4AAADI\ngix888QLAxfc7Dbsh2+3nbx4M0VtKFa2SqOXmpT0zsIIAAAAzjBq1MXa7r6wsp67J+IGs0IC\nxsTWToz+NhvPzVqW6XxKt3ijR4tsHAcAAAAullHYhYeHq9T6X47+7LidwZ7Hjh3L5XkBAAAg\nizIKO29vb5X64YXr/P39FZkPAADIY+zJZqtOr1XlxdEyY7PE2rX+GmUOlgdk9KnYH3/8ce+e\n7UIIIWyRkZH/27nrvygzVwAAoJhVFYL9So07/Mng4n7enh4a/4JlOo7+wibEkeUjwksX8tR7\nP1GxxoSVp9M+5cHVvYPaNy1ZwF/vFRgW3uD9xVttORhNCHHim2n1q5Ty8tAHFwt7Y+CMG8lW\nZ461rHxQQMgsc+yhjs9X9NYHPrBm/o32f+5f0bbx00E+BqNfgZrNOqw9HJX60JnNC1o9Xz3Y\nz0vr4VkkpOpbw+fGWB4OaEu5u2Bkt6ohhQ06nW9QiYbt3vn5rsnx0PASvr4lhqc9xPH3n1Kp\nVKlXjstg2Jxw6j12dmu8vzGgxtcXdrcLyfkhAQDAYyHxzoo6/e91GPRejRL6zQunrZj21rlL\nn53akTh48NjO1stzpsyb2OnpRs1j6/h6CCESbm6sVqHtNVWxDl17lA3W/Lp77YTezTf+tOzY\n512yMZoQIuqXcdXX/NSozVtDXvH5dc83q+YO3b73wrWjEZ7qzI9ls8S8Ve3F6Lqdps59x1Od\nydnBW/smhz4/3h78TOdeIwpqYtZ/9mn72pH3z11++wnf69/1q9xqkW/5+t0HjAj0sJzev/6L\njwYeuBly/qvmQojZL1UbuuPWC+16tule4v61IxFLFjT68dq9Gxt1mZ2OzHjYnHAq7FQavyEV\nAr9YelgQdgAA5BsW06WhO2581KCoEOKtDpU8g1oc2/j7nluXavvrhRAtQ34t++bOeX/E16kY\nJIT4uEn3a6qye6798lyQQQghxAcbh4S/OrPrlPGvjinjl9XRhBBx5/cMWX/u41fLCSGEffqy\nvuHdIhZ3/HbUupalMj1W/PUpsXOPbOtfPfNF2pM7tZxi82/yy8XNYV46IcSoEa2LFW4w9s2t\nbx9ov2vEGrW+xK/Ht5fUO17OnViguG9E5GIhmluSzg/bcbPEi9/sWPmaY6TXfGq3XLZ//d2k\ndgU8Mz5mBsM6+2fzH5y9QPF7P26ten1Av7mbov/55RMAAEBWOmOYo8OEEIbA5j4adXDl2Y4O\nE0IUqFVXCJGUYhNCWBJPTTodE9bn879KSwghXho3RwixetH5rI7m4F2k58OqE0KotJ1mbTBq\n1D+O2+3MsYRK/0Wvas6sMf7GrO33TE9Nn+OoOiGEIbD+xkXz33s7WAjRet+52zdP/5Vfwm5L\nMNvtdmuiEEKl9vRQidgz649cj3c8+tz0/VFRUZlWXcbD5pCzlztp0XaMrVDJRYNeXfSuoVCR\nAgbdP4rw8uXLOZ8KAADIU9TaoLR3tSqhLxCQelel1qXeNsV8b7Xbf5vxrGrGvweJ+y0uq6M5\nBFRp/Y/9DWWbBxq23v7RFBOV6bE8vKsV1Dl19ur+hV1CiNoNCqXdWPftPnWFEEIY/QNjDkd+\nHrn31PmLV69dOXPi1xuxZoO/EEJo9CV+mNapxeivni21slTlGrVq1qzXoGmb1k0CnfhcSAbD\n5pCzYWcwGIQo2rx50Vw4JgAAkIzaQwhRZfjS1HNyqfR+Tp05e9SjfaRVCZVa78yxVGovJ49i\nM9uEEB6q9Gts3ZCGbWbtKhbe4OUXarao/eKQiU/e6Nm4/52Hj9Yb/vmdLqM2bvx29959+7ct\n/3rJrMHv1tx4clfjNKcSU9ltdieHzQlnw27Lli2Z7lM/LHTP2Qs5mw8AAHj8GAJf0qgGWWLL\nN21aK3WjJensus2/Fn7SmL0xY05uFKJx6l2r+cqWaJPvcw0NgVVz8Vi+5aoLsW3/obuilG/q\nxp0j+nwZHbB4Vst2s3aVeCni6rc9Ux9a9teNlAfnfjkVG/TkU+17Dm3fc6gQ4sz3kyq+NG7g\n2GOnFz3nmHLaA90+EuO4kRz/cwbD5pCz77Fzxh9Xr+TiaAAA4HGhNZSdUDHwwpdv7bj19xvF\nVvZ75Y033riW3dZ4cHPh6O8u/XXP+vXQVx5Yba9Mr527x/ItNepJb4+D7wy9bHrYYclxBzrP\nWfLtoYKWxLNWuz2w2lOpOyf++dOMG/FC2IUQCbcX1axZs+0Hf39HQ+mnnxFCWBIsQgijRm2K\n+e7uX28ZNEX/3HfnDcftjIfNIb7pFQAA5IJBWxcuKdehWUjlV9u3fCo08L6/7fQAACAASURB\nVOTO1V9uO1+ly5edCmbzjJ2+gOGDlhVPduj2TIjPsV1rNuy5UqLppAXPFcrdY6k0fpu+6hv6\n6pwqZet37di0sC52w5KIP61eC77pYixgaBTUd9dHLfrrhj5V3Hjp1M+fRmwOKWxIvv7L3BVr\nu7Wd0KjAJzsm1XvpUtealcrYYq9s/HSpRhc0YWq4EKJlp3LvTz78ZIPOwzs2SLl1dvnMObeD\nPcQfFiGEsUD7DIZ9+43WmU05I7l5xg4AAORb3iXbnjjxbbcmJfeu/+y9SXMORwWOX/L9L0s7\nZnvAGrN/WvJe5+v7NkydPHvfZZ9uY5ec/G6MygXHKvXKrDNbFzUsE/fFvEmTZi2zV3r5873n\nepfzF2rDxmNbOjYotXHe+EFjP9533rbkyKWNa98r6ZM8rHe/OLvP5t+2929T59T3KyaNHjlz\nySb/Om9+c+jcm8W9hRDh7++eP/gNn+s7hvXpPmzCR7FV2v9vTf2Hx8tw2FiLLaO5ZkZlt+fC\neT+HEE/dxaSU3BrNdWw2W0xMTKa7+Xw0UYHJOBiatVPsWA5RlcsrfMS0PD09vQ8fV/ig7l2y\nXq/3PXpC4YO6d8larTbg+CmFD+reJavV6sDAQNXu/UoeNN0lK/nrSyj+G4wl/5fg4GBXzwTZ\nYDPf/yPKUrJ4oDKHy6cvxXp5OfthGVm59yeg1brhL557l6zRuOGLCt27ZLXaDS8IuHfJqv/4\nVJ1L5cPfZiw5XQkJCQrMBNmg1vuWLK7c4fJp2LnlPzl5int/Am757x9Lzg9H5085P2DJyJIr\nG1qEd8voPLrer/6tKxsVm4+r5dOwi4+Pz3QfHwXm4T7O/ARcx9Mz86ty5zr3Llmv1yt/UPcu\n2S3nZd27ZMdLsQofNN0l58NfX/lwyXBS6Ve/vfequyehIP4nAAAAQBKEHQAAgCQIOwAAAElk\nFHYNnqz89o9/Om5XqFBh4rVMXuOfMHturs0LAAAAWZTRu5tv/n7+wtQl+8Y11anF2bNnTxw+\nePDP9N+fWqNGDSFEp159XDJHAAAAOCGjsFvUv06D6ePrRo533F3XuvG6/9gzF69yDAAAgOzJ\nKOxe+HDnpTZ7j166ZbXb27dv32TO0m6Fsvl1bwAA4DHiumus+PjIfXUaN8vkQlNPPF3viaeF\nEOKbb75p2rZtu8L57nrfAAAAjwtnryC6du1aIUTijePfbNp2+tLNRKu2SJlKTVq1fqqEtyun\nBwAA3MNj8phcHzN57JRcHxNpZeHS8OvGte8wZY3Z9vfb6cYM6t1mzIrVE193wcQAAACQNc5e\nx+7y2g6tJ60uWL/b6m0Hb9yJvhd18/DOb95+vtCaSa07rb/iyhkCAADAKc6esft40GbvYl3O\nbl9iVD/8luunX3j9qfrNbKUKrxkwQ7w2z2UzBAAAgFOcPWO3KiqxXM+BqVXnoFIbB/YvnxS1\n0gUTAwAAQNY4G3bearXptunR7abbJpWGz08AAAC4n7NhNyjU7/cv+h65Z067MTnul/6fnvcr\nO9AFEwMAAEDWOPseu67fTBxfaUDt0k9269+1dtWyBpF08befls9fej7RY+7ari6dIgAAAJzh\nbNj5l+97epu2Y9/REVNHRvy1MbB8vQULvuwd5u+iyQEAALhaoE7z6um7n4UGuHsiuSAL17Er\n/kLP3Wd6/HH26KmLN81CX7RMxeoVSqR9Kbd+WOiesxdyfYoAAABwRhbCTgghhKp42NPFw9J/\n7I+rV3I6HQAAAGSXsx+eAAAAcKmUB6eGv9msXDF/o3+hhu2H/vYgxbE96c5PfV6tV9jfW6s3\nPlG57tS1Zx3br0RGNH+mYqCXPrhYmVd6f3DfahdCCLtZpVJNuR6fOmxRvfbtC/cyGEcmhB0A\nAMgD7Mk9wmsvPRPw4bLvdqyPKPjrZ8/XGOV4ZGTt5utuVvxs844j+7YNamx7741nL5usyfd/\nrNqin3jx3a17f14zf+jR5WNfmnc64yOkO47rF6aorL4UCwAAkPtizgz74lLy7pjl9fw8hBBV\nd9xt0eHrP5NtRTzUpXuO+qzLgOYFPIUQYSGjB81ucSwhOSg+Mt5q69W3Q80iRvFU+PZ1RS4Y\ngzI+RLrjPGHwVGB1iiHsAACA+/2x+SdDQBNH1QkhvIr22LWrh+P2oMF9dm1eN/3kuStXLh3f\n951jo3fxdzs+s+y10k/Ub9akTu3ajZu1erly4YwPke44kuGlWAAA4H42s02lNjy63Wq+3iK0\neLuJK+M0QXVbdJy7doVju1ob/OWhP37buazlM8XP7PyicbXizUZuS3dkk82ewTiS4YwdAABw\nv2ItqpomrTvyIOVpb50QIvH2lyHVhi87feXpa0O+v2r607SlkE4thEi88zDIbu+fOW1D8uyP\nR1ao/dJAIU5H1AofNlx8cMzxaEyKzXEj8c7aexabEOLe2fTHkQxn7AAAgPsFV5v3ciFb80Y9\nv9116Jf93/dt8q7Ju+WLAXp90DN2W/LHq3Zf/ePyTz983r7BCCHE6Yt3tAXj58wY1Xny8p+P\n/XZw98ZpC875lW8jhBAqfU1f/aoeU4+eu/rbge+7NeytVqmEEP81jmSfnuCMHQAAcD+Vxnv1\nbzuH9hg98M3GUVa/pxp1371oohDCp/iwyOlX3hndbv597ZPPNpyw7lThTlXer1O5WUzM9zPu\njpg/ot6EGL9CJZ5q0H33omGOoTb/b1777lPrVvo4yWqr3XV+uzvDMx7HncvObU6Gnc1sTlF7\n6HUq184GAADkW/rAZ+et2z7vke1Nhy04N2xB6t0XD137xHFr8LwXBz+6uyhQo8eO33rYbUm3\nY+yFg41C9Mt4nJgUeU7bOfVSrN0a72/0bLzmYsa7TZg9NzemBAAAkFMqtWfhYKO7Z6E0p87Y\nqTR+QyoEfrH0sGgXksFunXr1yaVZwT18Ppqo3MGatVPuWAAA5A/OfnjivR+3Vr0+oN/cTdFm\neU5XAgAAyMTZD0+0aDvGVqjkokGvLnrXUKhIAYPuH0V4+fJlF8wNAAAAWeBs2BkMBiGKNm9e\n1KWzAQAAQLY5G3Zbtmxx6TwAAACQQ1m7jt25HatX/nDg2p2Yeh9GtNf9dPBm1fqVC7poZgAA\nAMgS58POvrBrnX7Lf3LcMb43t/mDuS+Ef1uv+7zti/tpub4dAABySR47xd1TQJY5G3YXV7zW\nb/lPDfvNnjmozZOhxYQQAaHTp/aMHrW4f8vwhlv7hLlykgCQfUpex8csuJQP5OF79ESuj3n/\nqaq5PibScvZyJ5OHbAusMHL7/IFVyz78/ITWGDYyYv/7VYL2TJjksukBAADAWc6G3Td3k0K6\nvPno9lc7lzFF87kKAAAA93M27ErqNfEX7j+6/d6pOI2ea6AAAAC4n7NhN7pGwd+/6vzzXVPa\njYk3d3ZdfSk4fIQLJgYAAICscTbsXlv9SUnVtfpPVOs1dKIQ4tSqpZOGdakY2vSarci8tW1d\nOUMAAAA4xdmw8yzw0rFfN7/+jPrTmROEELvHDhk/4yufmm02HDvxehEvF04QAAAAzsnCBYp9\nQ5t9vbPZZ1GXT128adF4Fg+tVNxf77qZAQAAIEuy8s0TtqStn89duWXH2cu3LFqvUuWfbN62\na/eWNbg4MQAAQF7g7Eux1uQ/utUs3bzbyBWb9tyITU65dz1y5Sc9X6lZocWYeKvdpVMEAADI\nFYm3P1OpVFfMVndPxFWcPWO3Z0CTZYfvPP/OvOWTe5Xy0QkhLAnXFo95q/+cqY0mvHpw0tOu\nnCSAXKPk1zDwHQwAoDBnz9iNWXUpoPzYXXP6O6pOCKH1Ktlv9q5xFQJPLBjtsukBAID8xppi\nc+PT/5MlMdYl4+YqZ8PudGLKE2++/uj2198qkxx/MFenBAAA8qOieu3YbUvDC/votbrCZWt8\ncijqyOfDwooE6L2Da7w66O5fvWZLvjmtX+snQ4sbvIOq1G+z/KdbWXq6EOLOz8saVSvt6WEo\nWr7GhC+OZjxsoE4z79r1IW1eKPZEZwV/GNnkbNi9EuR59+DVR7dfP3BX71s3V6cEAADyqZmv\nzui9dPv5k/tb+1zqW7fKa6vsy344tGf1hDNb5rVfd9mxz5j61T/aoxo+58ufdqzv/Zx4u17Z\nTy/EOf90IUTLFlPrD5y5c8emd+p5TOzyzJgDtzMe9pvuL/m9NHTPgU+U/WFkh7PvsZu85O2Q\nVzt88O3hkS0qpG48//1H7b+9VvW9da6ZG+ByvOEMAPKU6rPX93qpvBBi7MJnF9aO/G7dB1WM\nWlE1dHiJsSt/jBLtQx7cmPXhwahdMV/V99cLIarXqJ+yKWhi3x+7b2vhzNMdR6mxZNt77UOE\nEM/VbXr/p6DF3VeN+p8tg2HvPDFnXNcGbvqRZE1GYTdgwIC0d58vrh71csXF1es+UyHUVxV/\n4ezRvUcuaTwKtQz4SYjqLp4nAACQX6HawY4bOn+DRl+yivFhqARp1XabXQgRezbSbrc9H2BI\n+yz/5HNCtHDm6Q79XyyeertDz9CZ49bEnvXOYNiyXSrm6ipdKKOwi4iI+PfeWu0fJw78ceJA\n6l1hix4/5N3R7/R31QQBAEA+lc4bxnR+nmqtf1zsH2kvo6tSezj59Ecf8Aj0UKl1GQ/rG5ju\n+HlRRu+xS3GaYtMFAAD5mV+ZHnZr3OKbKV4PGce/0rTnV5eyNMiC7TdTb6+cccavXKdcGTYv\nyMo3TwAAALiVIbD5rMbFRtVp6T131HPlArZ9NnTO/htb15bO0iBbOjf+0DSrYVmvvV9OmfDb\n/dknXzEEBuR82LwgC2GX9OfZ/UdPRyekc36uXTveFQ4AAJQw4Nujie/0nNq37S2zPiz8hS/3\nbmwckIUvr9d4FPlhZpsR7/cYf91UttpTH60/+U6FgJwPm0c4G3ZX1g176o2ZMf9xyT/CDgAA\n5NBNsyX1dlCFdSlJfz/U50JMn79uq3UFRy3aOGpRdp5uLPS2xfy2EOJw72n/evp/DRuT8jh9\n/5izYTeg14L7mhLj5097oWJJrSrz/QEAAKAwZ8NuZ6z5yfc3Tej5pEtnAwAAgGxz9psnavt6\nGAoaMt8PAAAAbuJs2M2a2OjIsG5H7iRlvisAAADcwdmXYiv139hjfoHnSpZt2Oz5EsHGfz26\nZMmS3J4YAAAAssbZsNs3su78c/eEuLfj+/WPfniCsAMAAHA7Z1+K7Tv/iHeJ1geuRKeYkh7l\n0ikCAADAGU6dsbPbEk4mWuounlazVKCrJwQAAPKC+09VdfcUkGVOhZ1KpS2l19w7HiU6lHX1\nhAAAgNv5+Pi4ewrIDudeilXpv53X6eyc5rO3nLS7eEIAAADIHmc/PNH78wvFtPHvtqwy0r9Q\nAW/dvx69fv16bk8MAAAAWeNs2AUHBwc3bVEtu4exW+5tWLL4+59+jTapi5QIbdmpd9Pwwtkd\nzLZ71cIte3+5Hq8Jq/xslwFdyxi1QojbB8b0mPZb2v26LVvTKoiLKgMAgPzC2bDbsGFDTg7z\nv6lDV5z27dLznbCiXid2rFw4oV/S/M9blfDOxlCX1o2dtfpqx379uwVYvlu8YMy7ySsW91ML\nEXs81jPo5YE9KqXuWcrn32cWAQAAJOZs2MXFxWXwqJ+fXwaPWs3XI47erT/145crBQghQsOq\n/Hmo3caFJ1tNq+n8RB+yJ89cfSbkjY/bNAoRQpSdrmrTefqKG106FfO6c/q+f8VatWpVynQM\nAAAAKTkbdv7+/hk8ardn9JkKq+lKqSeeeKmM718bVOF++gOxD4QQdkvMuk8/2Xvs3I17yUVD\nqrZ6q2fDsIA0w5qvXr1TunSJ1C3muL3XTNY+jYs57ur964R7zz66+1anDiHH75sDwv2tSfej\n4m2FCvo/chFlAAAAyTkbdhMmTPjHfbvl5qXTG1dvilEVm7BoasbP9fCrO3t23dS7KQ/OLr35\noFTX8kKIL0cNikyq1LPH4BK+qrMHvps7spd14fImRR9+ZZnVdHnQ4Gkb13+e+tzkhBNCiIrG\nv19jrWDURp6IEx3EsQcp9n1z2847m2K3a70KNH1zYK+X/74Az8KFCw8cOOC47e3tPW/evEyX\nbM10j8dZuqXOkiXDkh1YsmRYcrpiY2MVmAnyPmfDbvz48Y9unP3RwYbl6s+ec3RM1w5OjnP1\nyNa5c5amlGk25sXipuhN687HTfl6cGUvnRAipFxl68EOqxadajLpmf96us2cIIQI0v59lZZg\nncbywGRNvvFAoysdXOvDFRP97fEHty79aMlYfegXXcIe/mO4efPmmTNnHLcDAgK02swXLvev\niXR/AixZMizZgSVLhiUDGcjR3xXPQjWWTKxWedCsPXHT6vvpM945+d65pfPmfn8spn7rPlPe\nbGBQqe7+8Yvdbh/9xutpd/Oy3BD26iZzihDCYjILIUwmk+MhvcGg9vAUQtyz2Lw1GsfG6BSr\nxt9D41FszZo1f42hr9tu+PnIozs/Pdnl4zqOTfXq1StUqJDjtsFgcOZr0Jz9trXHU7o/AZYs\nGZbswJIlw5KBDOT0fwKMxY0qlaa8MZPPn8Zf3TFk6HxNlWbTl3QuH/zwEiRaLw+Vxmv1ymVp\n91SpdYlRK9t3T6000bZtW8eN2Ws2FPWqIsTec0mWEvqHYXchyeJXJ51z1OGFPLfHRKXebdKk\nSZMmTRy3bTZbTExMpkuT+5LbCQkJj25kyZJhyQ4sWTIsGchAjv4nx5YSNeu94zrv8MK6jMax\n2xKnjFiob/jOwnE9U6tOCGEs1FTYEiNjrIaH9F9PGb9g1y1jwY6bN2/evHnz+tXT1dqAzX8p\nY9AY/F8o6qH5Yd8dxwgpCccPxSdXb1Q49vyCt7v3u5VsS53anpuJ/hXL5WR1AAAAjxdnz9g9\n99xzj2yz/XnhxNVo09Nj52f83MQ7K04npnStYjx65MjfB/YsW63S092rBX0+YrKhZ+uwYt7H\nty3dciZ6/IiCGY2l8hjaOmzY8gnbiwyvFJCyecEMY5GGnYt7C0u7oMTeIyYs7v9mA39V0tFt\nX+1N8BnXnbADAAD5SE5eilWXqNKgVcOO08fUyHi/+N+vCCGWfTgl7UbfEqO/WlCzxbhZ5k/m\nr4348F6KrniZqoOnjan2yPeV/UvZdpP7mmevmjUu2qQKebL+5Ik91EIIbfCkBe8vi1gxd/JY\nk8anTGjl4bMmhGc2FAAAgEycDbvUa4VkQ+E6UzbXSf8hlcavdZ8xrfuk/6jWMyzttU5Sn9P4\nrSGN3/r3Zn1Apd6jpvbO9iwBAAAec1k7Yxfzx6WohJRHt5cvXz6X5gMAAIBscjbsTHe3v16n\n3dZz6X+YNONvngAAAIACnA27T17p9P2F+BZ9Rr5YtbSWr+sCAADIe5wNu8mHo8q0W79lYUuX\nzgYAAADZ5tR17OzW+KgUa6l2VTPfFQAAAG7iVNipNN7P+xsuLT+S+a4AAABwEye/eUK16ttJ\nyd937DLp89sJFtfOCAAAANni7HvsWo/cVKiI7vNxXb4Y/3Zg4cKemn98gOL69esumBsAAACy\nwNmwCw4ODg5uVKqaSycDAACA7HM27DZs2ODSeQAAACCHnHyPHQAAAPI6wg4AAEAShB0AAIAk\nCDsAAABJEHYAAACSIOwAAAAkQdgBAABIgrADAACQBGEHAAAgCcIOAABAEoQdAACAJAg7AAAA\nSRB2AAAAkiDsAAAAJEHYAQAASIKwAwAAkARhBwAAIAnCDgAAQBKEHQAAgCQIOwAAAEkQdgAA\nAJIg7AAAACRB2AEAAEiCsAMAAJAEYQcAACAJwg4AAEAShB0AAIAkCDsAAABJEHYAAACSIOwA\nAAAkQdgBAABIgrADAACQBGEHAAAgCcIOAABAEoQdAACAJAg7AAAASRB2AAAAkiDsAAAAJEHY\nAQAASIKwAwAAkARhBwAAIAnCDgAAQBKEHQAAgCQIOwAAAEkQdgAAAJIg7AAAACRB2AEAAEiC\nsAMAAJAEYQcAACAJwg4AAEAShB0AAIAkCDsAAABJEHYAAACSIOwAAAAkQdgBAABIgrADAACQ\nBGEHAAAgCcIOAABAElp3T8A9goKCMt0nWYF5uE+6PwGWLBmW7MCSJcOS0xUdHa3ATJD35dOw\nu3//fqb7GBSYh/uk+xNgyZJhyQ4sWTIsGchAPg27lJSUTPeR+9dEuj8BliwZluzAkiXDkoEM\n8B47AAAASRB2AAAAkiDsAAAAJEHYAQAASIKwAwAAkARhBwAAIAnCDgAAQBKEHQAAgCQIOwAA\nAEkQdgAAAJIg7AAAACRB2AEAAEiCsAMAAJAEYQcAACAJwg4AAEAShB0AAIAkCDsAAABJEHYA\nAACSIOwAAAAkQdgBAABIgrADAACQBGEHAAAgCcIOAABAEoQdAACAJAg7AAAASRB2AAAAkiDs\nAAAAJEHYAQAASIKwAwAAkARhBwAAIAnCDgAAQBKEHQAAgCQIOwAAAEkQdgAAAJIg7AAAACRB\n2AEAAEiCsAMAAJAEYQcAACAJwg4AAEAShB0AAIAkCDsAAABJEHYAAACSIOwAAAAkQdgBAABI\ngrADAACQBGEHAAAgCcIOAABAEoQdAACAJAg7AAAASRB2AAAAkiDsAAAAJEHYAQAASIKwAwAA\nkARhBwAAIAnCDgAAQBKEHQAAgCQIOwAAAEkQdgAAAJIg7AAAACRB2AEAAEiCsAMAAJAEYQcA\nACAJwg4AAEAShB0AAIAkCDsAAABJEHYAAACSIOwAAAAkoVX4eMv7vGWYGNG+gGcOxrDtXrVw\ny95frsdrwio/22VA1zJGrRDi9oExPab9lna/bsvWtAoy5Gy+AAAAjw0lw85+4cfPNtyMbWO3\n52SUS+vGzlp9tWO//t0CLN8tXjDm3eQVi/uphYg9HusZ9PLAHpVS9yzlo8vxnAEAAB4bCoXd\nnQOzR8zbF/0gOacD2ZNnrj4T8sbHbRqFCCHKTle16Tx9xY0unYp53Tl9379irVq1KmU6BgAA\ngJQUeo+df6U2YyZ+8PGHI/613W6J+Sbig3d6dX29bYcBoz7ccfbePx61m69cuZ52izlu7zWT\ntXHjYo67ev864d4eR3ffEkIcv28OCPe3Jt2/dSc2R6cEAQAAHk8KnbHz8C1W1ldYk//9jrcv\nRw2KTKrUs8fgEr6qswe+mzuyl3Xh8iZFjY5HrabLgwZP27j+89T9kxNOCCEqGv9+jbWCURt5\nIk50EMcepNj3zW0772yK3a71KtD0zYG9Xq6autvFixejo6Mdt9VqdWhoqItW+rjQ6fLd69Qs\nOT9gyfkBS05XSkqKAjNB3qf0hyfSMkVvWnc+bsrXgyt76YQQIeUqWw92WLXoVJNJz/zXU2zm\nBCFEkPbvE43BOo3lgcmafOOBRlc6uNaHKyb62+MPbl360ZKx+tAvuoT5O3ZbtmxZZGSk43ZA\nQMC2bdsynZ45J2vL8/z8/B7dyJIlw5IdWLJkWHK67t69q8BMkPe5M+we/PGL3W4f/cbraTd6\nWW4Ie3WTOUUIYTGZhRAmk8nxkN5gUHt4CiHuWWzeGo1jY3SKVePvofEotmbNmr/G0NdtN/x8\n5NGdn57s8nEdhRYDAADgbu4MO62Xh0rjtXrlsrQbVWpdYtTK9t1TK020bdvWcWP2mg1FvaoI\nsfdckqWE/mHYXUiy+NXxf3Tw8EKe22OiUu8OHjy4T58+qXfv3bv36FP+xZiVtTx20v0JsGTJ\nsGQHliwZlgxkwJ1hZyzUVNgORcZYWxX1EkIIYV/63sjYOu8Mbtpx8+aOQghL0tnWHf7xHjuh\nf6GoR8QP++40alFCCJGScPxQfPJrjQrHnl8wZPrpKQvnFfZwvEpr23Mz0b96udTnBQYGpt62\n2WwxMTFKrDAPs1qt7p6C0lhyfsCS8wOWDGTAnd884eHzdPdqQV+NmBz549Erl85tXDxyy5no\nBrULZvQclcfQ1mG/L5+w/ei5Py+dXDpuhrFIw87FvX3LtAtKvD1iwuLDJ89dOHV81ezhexN8\nenYvl9FQAAAAcnHnGTshRItxs8yfzF8b8eG9FF3xMlUHTxtTzTuTz/6UbTe5r3n2qlnjok2q\nkCfrT57YQy2E0AZPWvD+sogVcyePNWl8yoRWHj5rQnhmQwEAAMhE0bDTeBTfvHlz2i0qjV/r\nPmNa90l/f61n2D9eh/3rOY3fGtL4rX9v1gdU6j1qau/cmisAAMDjxp0vxQIAACAXEXYAAACS\nIOwAAAAkQdgBAABIgrADAACQBGEHAAAgCcIOAABAEoQdAACAJAg7AAAASRB2AAAAkiDsAAAA\nJEHYAQAASIKwAwAAkARhBwAAIAnCDgAAQBKEHQAAgCQIOwAAAEkQdgAAAJIg7AAAACRB2AEA\nAEiCsAMAAJAEYQcAACAJwg4AAEAShB0AAIAkCDsAAABJEHYAAACSIOwAAAAkQdgBAABIgrAD\nAACQBGEHAAAgCcIOAABAEoQdAACAJAg7AAAASRB2AAAAkiDsAAAAJEHYAQAASIKwAwAAkARh\nBwAAIAnCDgAAQBKEHQAAgCQIOwAAAEkQdgAAAJIg7AAAACRB2AEAAEiCsAMAAJAEYQcAACAJ\nwg4AAEAShB0AAIAkCDsAAABJEHYAAACSIOwAAAAkQdgBAABIgrADAACQBGEHAAAgCcIOAABA\nEoQdAACAJAg7AAAASRB2AAAAkiDsAAAAJEHYAQAASIKwAwAAkARhBwAAIAnCDgAAQBKEHQAA\ngCQIOwAAAEkQdgAAAJIg7AAAACRB2AEAAEhC6+4JuIfBYHD3FNwsH/4EWHJ+wJLzA5acLpPJ\npMBMkPcRdv/JqsA83CfdnwBLlgxLdmDJkmHJ6SLs4PD/9u48IIr6/+P4e/ZgD0BAEE80xRvz\nTjOzTNPs8MhQ8UhNzX6alpp5H+UR2aV5lFmaR+WV9tXMrOzSb5rfyq+lhnaY4okoiALCsrvz\n+2MNyYLMr+yyn30+/pr9zOxn3p8ZmH3t7sxsgAa7c+fO/e0yoV6oubwEBAAAGS1JREFUw3f+\ncgswZMUwZA+GrBiGDBSBc+wAAAAUQbADAABQBMEOAABAEQQ7AAAARRDsAAAAFEGwAwAAUATB\nDgAAQBEEOwAAAEUQ7AAAABRBsAMAAFAEwQ4AAEARBDsAAABFEOwAAAAUQbADAABQBMEOAABA\nEQQ7AAAARRDsAAAAFEGwAwAAUATBDgAAQBEEOwAAAEUQ7AAAABRBsAMAAFAEwQ4AAEARBDsA\nAABFEOwAAAAUQbADAABQBMEOAABAEQQ7AAAARRDsAAAAFEGwAwAAUATBDgAAQBEEOwAAAEUQ\n7AAAABRBsAMAAFAEwQ4AAEARBDsAAABFEOwAAAAUQbADAABQBMEOAABAEQQ7AAAARRDsAAAA\nFEGwAwAAUATBDgAAQBEEOwAAAEUQ7AAAABRBsAMAAFAEwQ4AAEARBDsAAABFEOwAAAAUQbAD\nAABQBMEOAABAEQQ7AAAARRDsAAAAFEGwAwAAUATBDgAAQBEEOwAAAEUQ7AAAABRBsAMAAFAE\nwQ4AAEARBDsAAABFEOwAAAAUQbADAABQBMEOAABAEQQ7AAAARRDsAAAAFEGwAwAAUATBDgAA\nQBEEOwAAAEWYvLUi9xerXnl/2+6jF4y16zXrP/yhavZrXnVhXV3HVQAAAPgfL31id2jdpNmr\nd97c9eGpI/qG/PrpxJGvua93V9dxFQAAAP7IK8FOd7y0Oim257Rud7aIa9Lq8eeGZZ386O3j\nWdezq+u4CgAAAP/kjWCXm7EtOcfVrl1Fz0NL+K2NQoK+++KUiOjOtHcXPvvYIw890L338PGz\nPj2QXvCJup57+PDRq+mqiFUAAAAECG+chebI+kFE6trN+S117KYtP2RIb1kxfsSWi3GDHx4V\nU0o7sPODueMecb2ytH0Fu2cxV85vI0Yl/mv9sr/tytG60FV4rFq1as+ePZ5pu90+duzY4hmr\n3wgNDfV1Cd7GkAMBQw4EDPkvXbhwwQuVoOTzRrBz52aJSKTp8qeDUWajMzMn5+yGdT9lzHxn\nVL1gs4jE1qzn2tV71av720+/6Z92VVh7/sN9+/Zt3brVMx0RETFlypS/LTv3qgfojywWy58b\nGbJiGLIHQ1YMQ/5LBDt4eCPYGYJsIpLudIcYjZ6Ws3kuY3hQ5rHduq5P6PlAwYWDncdFb5yT\nmycizpxcEcnJuZTPLFZrYV0V1p7fbb169ZxOp2fabrfn5l7FQWDa89c64n/GZDLpRqPb7c7L\ny/POGkXkr7eAt4ZsNBp1k0nXdYfD4Z01iq+HbDAYdLO50DKKRwkZssPh0HXdOyv17ZA1TQsK\nCtJF8vLy3G4vXb7l2yGLiMVi0UWcTqfL5fLOGn0+5KCgIF3TXC5X/stKcfPmcQP+zhvBzhx8\no8i2gxedMZZLqevni86wW8NNwUGaMXj1yjcLLqwZzNmpKxMGrclv6d69u2dizpr3KhTSVWGr\nyO8kISEhISHBM+12u9PS0opnrNciJCTEaDS6XK7Aeb9ls9lMJpOu64EzZIvFYjabJZDeVZtM\npvDwcBHJysry2ku+bxkMhtKlS4tIdna2N9+n+Zbnw6ScnJz8N+HKi4iIMBqNubm52dnZvq4F\nuJI3Lp6wht9RIcj40b9Pex7mZe35zwVH4zvL2cveJe7sLWku6yWWd2ZOXfD5KXt0n40bN27c\nuHH96ucMpoiNv6tmNRbWVWHtXhgdAABACeGV251oQaPja/+y9Kmt3x08eWjfkikv2su37Vsp\nJCi06aCGkW+NnbFl+3eHDx3812vj3k8626Zl9DV0VWg7AABAwPDSbzNU7zFjaO6cVbOnnM3R\nYhvcPmPaw55Eed+U2bmL5q9dOCs9z1ypWv1RiRMbhpivravC2gEAAAKE5rWTmkuOEniOndVq\nzcvLy8jI8HUtXmKz2YKDg0vajihWFovFc8OCM2fO+LoWL8k/xy49PT3QzrHLyMgInHPsoqKi\nRCQzMzPQzrHLzs4uaefYefYFAhyfagEAACiCYAcAAKAIgh0AAIAiCHYAAACKINgBAAAogmAH\nAACgCIIdAACAIgh2AAAAiiDYAQAAKIJgBwAAoAiCHQAAgCIIdgAAAIog2AEAACiCYAcAAKAI\ngh0AAIAiCHYAAACKINgBAAAogmAHAACgCIIdAACAIgh2AAAAiiDYAQAAKIJgBwAAoAiCHQAA\ngCIIdgAAAIog2AEAACiCYAcAAKAIgh0AAIAiCHYAAACK0HRd93UN3uZ2u9PS0nxdxWWpqanp\n6ek2my0mJsbXtXhJenp6amqqyWSqVq2ar2vxkszMzBMnTohI9erVDYaAeEOVk5OTnJwsIlWr\nVjWbzb4uxxucTuehQ4dEJCYmxmaz+bocL/n55591XS9btmxYWJiva/GSw4cPOxyOqKio0qVL\n+7qWP4iKivJ1CfC9QAx2JU1iYuK6devq16+/ZMkSX9fiJUuXLp0/f36ZMmU+/PBDX9fiJR9/\n/PGECRNEZOfOnQGScn744YcBAwaIyPr16ytXruzrcrzhzJkzHTp0EJEFCxY0b97c1+V4SYsW\nLfLy8iZNmtSlSxdf1+IlXbt2TU5OHjhw4JAhQ3xdC3ClgPjkAAAAIBAQ7AAAABRBsAMAAFAE\n59j53oEDB44dOxYWFnbTTTf5uhYvOXz48C+//GKxWFq1auXrWrwkJSVl7969ItKmTZsAuXgi\nIyPjm2++EZFbbrnFbrf7uhxvcDgc27ZtE5HGjRuXtNPqi89nn33mdrvr1q1boUIFX9fiJTt2\n7MjOzq5atWpsbKyvawGuRLADAABQREB8cgAAABAICHYAAACKMPm6gECxd+uqNZu//Cn5lMto\nj46pcfvdPXq0reProorF5J7x32c54l99p2/FkILte54fPGX7qSqdXpg3qKavais+24f2fv7Y\nhT+3a1rQhg3ver+eYnVw4aNjtpxevm5NmFHztHz0WJ9XjmS+uHpddavR07L76YHT9xrWrn3d\npF1Vn28PTPj2zmdm9yzpN6wuekf369ql/rwVT1QM9X5hXvPdk/2ePph+RaMtquvqJf2vaOzU\nqVOX11cNKOvHp1dew3E78+SxC9bo8hFB3qkQ+DOCnTcc2Th90uI9bbsPiB9Yw+LOPPTDjhXz\nxx3MnD2lc0l/Gbs2mlHbvvynvuMbX27SnW9+c8aoXd2LvB+qP3LyM7lOEdFdFyZOTqw1ZHy/\nmFAR0TQFPxSvcG99ffMHG85c7FvWLiK6nrPyeKauu1clpU9qdOnG95/8cj64wsNXmer8SEDt\n6MJYw9tMGXNnwRajucyfF7v77rtr2/z4JebajtvbnxqzqeGUBUNqe61O4Ap+/F/nR95c/X2F\nNlMe693A87D2jY3r2H8bteJZ6bzoap7ucutGgz+9Qpa9o37q9jcc+oKg35Nc1omVye6o28PO\n/XrVnfjXqMNq1Pb8mpLuSheR0Ng69WqG+7ak4hNSvrvFsHnP9tN9428QkYun16U7TX1jbe+v\nTpJGrUTE5Ti+87yjdr84HxdaDAJqRxfGYC5Tr169IhZw5WYZLcH+/qsM/+NxG/CVAHqX6UPZ\nLj03PaVgS+W7H504brAuInpep06d1py5mD+rX9cuc09keibWHt03beiDXe/v0rv/4Hmrd3q5\n7GtWqkrfcnJyRXJmfstPb20vfeMgW4E/N1fu8WUvTe3fq/v93RIenzBr+2+Xvt7y31EXqvBd\nrDvT3l347GOPPPRA997Dx8/69MCV33CVTJopomNpW8qn+zwPj2/+2lamS+sHa5z/9R2XLiKS\nnbLBrettm0ZJ4WPMOfP93GnjB/SK79l3yIJ3v/bRUK4/tzN9WeKYhG739+r38NyVO0WK+gNQ\nTK/7O29KPbNk1sT+g2aLSHznzktSsn1d1LUr6rgt4sg48Ooz4/smdO/SNX7QsHFrvzomIq/1\n7/7qycyjH47p1meWL0oGRAh23jGw841nds8f8MRTy9/94Pufjjp0MVqrNW3a9G8/j9o0YVaV\nLsPnv/bKsPvrfPJ24qrTfnKUNFgGNY7asfTHSw/1vCXfpd7cv+C5KfrCkU9u/tHd7/GJs6aO\nbhx8+KXRj+/Pdnrm+euo/7kV40es36d1fXjUczPGd6gtc8c98vEJ/xjsLa3LZqf+yxPjPvsy\npcJdLSPqJLgdJ95PyxGRU1uTjJaKbcMtUsgYdefZqcOn7zoT/tDIqROGJaR/Mmfj2YtFr9Ff\nfDd9sjSNf2He/OFd625dmbj2jCLjKsidl5r0R67f75r11byn7U3uT3z+UZ8WeH0UfdxeNubp\nHWkxj02e8dKs6Z0but96/okUh3vgohUDywVXbDfjrcWjfFw9AhhfxXpDrZ5Pzau7/bN/7/rv\n1jXvLn/NaA2rd9Ot8f36NYi2Fv3E4JtH92vfQERiOo+s+vb2A6k5Eu0fZyLX6tsq7fE3Lrqb\n2Qxa5ol3jrnLvVA5ZOnvc7NTVn50LHPEmxPviLSKSI26cft79Xl9/ZE5fWLFn0f9j+Sc3bDu\np4yZ74yqF2wWkdia9Vy7eq96dX/76X5wn+oK7Zu43n3384zcO2ynt6Tn9mtT3miztg23fPHx\niS49q/13R2pIzGBD4WNs2PHDgznWF54b7bnYolYdW48+M309pusjosGofu0aiEilziMrvrUt\nKS1XIlU7zOac+2zs2M8Ktix7b0OEURORjLIPJ9xZ30d1XWdFH7ej7+o2vO19TcOCRKRSue6v\nb5x2KNdZNtQSpGkGU5DFYvZ1+Qhcqh1xSqwqDVo91KCViFxMO77n212b1q5+auieOW/Pr1Lk\ntVPl2lXJny5lNIj/3Ew6pEKvKoZ/LT18fki1sJ+W/zuy4SOWAldOZCTtNVoqtYm8lGs1g61L\nefuCHcnSJ1b8edT/SOax3bquT+j5QMHGYOdxET8IdrYyXUOM6z7fl94kcqWYy3csbRWRDrdG\nT/7kC0mo9P7ZnJg+daTwMaZuO26NaJ9/CW1QaLMmIeaz3h9GMajY4Y9/vSqyl+mxanHvv5xV\nvm2Ml4spVoUety3GTl3u3rtrx/rk4ykpp35L+sbXlQKXEeyKneP8Vy/M/7Lv6LGVgowiYitd\nsUX7rk1vrfVAwvi3j1yYUCP4iuXzCvwWiNlm9Gqt15Fmeqh5mZeX7B0yvdni3WdavlSr4Exd\nF5E/fBFtMGiiuz3Tfjzqq+PZxabgIM0YvHrlmwVnaQb/eKOvGUO6lrFv2vTbr9aDpar29dz2\npFLHm3M2rf8lJTLD6R7UMFIKH+Mv87dc0WGYyaBGsLPZ//6vN0/d3/uxhyrymlL0cXtcVeeM\nocN+Cq57V8uGcTfVbtfp9lGPTfN1ycAlar6hLFGMQeW/2bVr9e4/vGy5cs6JSLmQS6/imc5L\nB/rcjK8yXYoc9Gv0bpOWtPhk8lsnpELvSn+4s1d43ThX7tEv0nM8D3V3zobjWZHNq/xVN4r4\n8y62l71L3Nlb0lzWSyzvzJy64PNTPi3zH2javvyFwxvXHDhXtUddT4utbHxpk3vB+g9N1htu\nCwuSwscYfVvFnHOf/Jbj8jzRlfPrjvO5PhuJVyj5P66woo/bmccWf3faMf/FyQ9263RbiyYx\nEQpeCgP/pci7q5LMaK02vmOtmbMet8QnNKtTNdiinTt5aPOKt0Kr3t23fLBoUstu3jZ/zW1D\n7jFfOLpmwSuaKjd7s5eNr2FeM+2FT8o0fjJIu2JWr3YVP1g4dpbxkfiKwc6v3lt0IC9sendF\ng51m/stdHBTadFDDyGVjZ1gHx9euGLLnkyXvJ52dOjba1+VerbKtb8lbvvyASGLdCE+Lpll7\nVQ6dt+VERO0nPTu8sDFGWYfWDBo8efzsoQ/eU9qQsXn5glCLuh/TFvIHgJKs6ON23tkauv7V\ne9v23ntj2bTk/e8uWSEiySfPNQ+NNmhyMeVEenqFiIhSvh4EAhTBzhuaDZo1tfLK9z7aMnvD\n6YtOLSK6UsPWfUb26ei5feukaYOfn7d23KPvOdx6nTsfaXVuqY/LvV40Y/+W0eM/Od5tXK0/\nzTMMnf1c6IJFbzw/9bzTUKlGk1EvDK1n949vIa9BYbv4vimzcxfNX7twVnqeuVK1+qMSJzYM\n8ZuNYI3sGGF6Kzu4RZz98mGkfveqkrin8v2Xf1ykkDFGTps38ZW5y19+ZqJYo27rPvb/dr20\nwhej8A5l/8eVVsRx2xTV9an+p19f8dwH2cYbajToNX5BxEvDVo0d1mTlyrjOzXOXzBsy+rZV\ni0f6egQIUJqu7tke/kXXHecu6BGlLL4uBMWFXRzg+AMA4AUEOwAAAEVw8QQAAIAiCHYAAACK\nINgBAAAogmAHAACgCIIdAACAIgh2AAAAiiDYASguccFBFVp8eJULnz8ySdO03gfTirUkAFAb\nwQ4AAEARBDsAAABFEOwAAAAUQbADAs7M6hEmS4Vs96WfEzy65R5N00rFjMlf4MteNTRNW5qS\n7XmYeWTbiIS7KpcJtwSXrt2ozdOvbXYX6K3ouZfpjhcT6hiMlidWJnkavln17J1Nq4dagyLL\n10h4fM5pxx+el7RxQZfWjaPCgk1BtvKx9fuNmZvm1EUk6ZWWmqbNO55ZYFl32whbSPkB/+Nm\nAQAV6AACzP55N4vIzCPnPQ83tYsREYPRftLh8rT0jg62lGrpmc48/l6szWy239D/0dEzpo7t\ndns1EWnY982rmVvXbi5/82Zd13V33pzecZrB/PiKfZ5Z38/vISLWyEYPDRv35P/1qRlsjmhQ\nXUR6HTir63rypqEGTQuv3Xr0xKefeXpyn/ZxIlKj9yZd13PSPzVoWtxjX+cPJ+O3Z0Tk1leT\ninWjAYBfINgBAScrZbmINHlmj+dh+whr2dY3i8iIg2m6rudl7TVqWtUuH3nmPhUXabbX2XHm\nYv7T3xvVUERm/Hrub+deCnbuvPn9btQ08/Blez3LOC/+HB1ktJftuO+8w9OSeezTWnZzfrBb\nFhdlslY+kuPM73ZkxVBbZEfP9IhKobbS9+TP+qhHrGawfHvBcX23EgD4I76KBQKOPfrBlmGW\nX9/YJCKOC19/nJ5z13OLQ42GTxf9IiJp+5916XrbKY1ExJm9f/qPabWHLGsRac1/+j1TXhaR\n1a/+VPRcz0NdXAsH3TRs2d4qndbO7VvP05i6e/xph6v9sgVxoWZPS3DFNiuG1s7vJP7fB1NO\n/FjZYrzUiTsrV9d116WvhgdPrH8xbfPiU1meWSPeT46sl9gkxFwMmwoA/AzBDghEk1uXP5/8\nQprTnfbDi5pmHF+v5shKoUfWrBeRH1/aZTCVmh4XKSI5aR+6dH3vi820Aizht4tIxt6Moud6\nVpS6u8+jy39rFm45umXojvMOT+Pp7YdFJKFxVMGSYh9qlD9tDy+d/cv22dMnDHqwR7vbm8dE\nRr5y4vJJddV6Tjdo2ryXD4jIme/HJGXntZ/Toxg3FgD4D5OvCwDgA40m3+He8Oasw+c7zNlt\nL9Ozts3U+cGqMxLnnc6b+fpnJ8Jjp5ULMoiIGIJE5MYxS55vU+GKHixhDcXwY1FzRUREd2vP\nbN47IHxJdLOpPeIXHf14mIgYTAYRMWh/eIrBGpE/ve6Jtt1mf16xUZuOd9x8X8sOT0xrcHxw\nu2Gn8zu/Y0SlkIWLn5XEtVtHbjBZKs9tVe46bRgA8HO+/i4YgA84c4+GGA03jv5P7+jg2O6f\n67p+7tBEERm+Z5tB01otOehZLO/iz0ZNqzP4q4LPzctOWrVq1Rcns4qeq+t6Xbu5XPNNnvZF\n91UWkQlfndJ1/dSuHiLS9ZOjBZ+YtOgWEel14Gzu+Z1GTat872sF5y6pWdoa3vbywq/dKiIr\njv1cxmy8odPG67RVAMDvEeyAADUjNtwWdb9R03rsPKnrutt5rrTZUL5dLRHZcPbyxRDT4yJN\ntupbT2bltyx/qKamactTsv527uWrYnXdceHbKlaTLbL92TyX8+Kh6CBjSIWuBzLzPHNzz+25\nPdzqCXZZp94UkYYTv83vM+vEV3HBZmt4m/yW3HNfGjWt4r21ReTpn9OLY/sAgD8i2AEBav/8\nmz0f23/z+/WkibHhImKLvK/gYheOrK5sMZntVbsPeHxW4tMPtqsrIjf2X3E1cwsGO13Xk17r\nKCI3Tdyu6/r3c7uJiK1M08EjJ00a+XDDCGvVDgM8wU53Xbwz0mYMKvfoUy8seeOVSSP7lrOF\nt6waajCFv/zWmkyX29Pb6MqlRMQa3sZV3FsKAPwHwQ4IUFkpK0Qk/x4iuq5/n9hURGr223bF\nkucObnmky+3lwkOC7KVrN7x16usf5rmvau4VwU53OwbFhhlMpTakZOu6/vXbM+9oVC3EYgqN\ninng0fkXMn+U3293kpm8tV+H5hUjg0uVq9b63j7v709L/fa5GyLsQSFljuVeugfKgUW3ikiD\n8d8Uw7YBAH+l6bruvRP6AOA6+XZCw2bP/vBeanbnAjdbAYAAR7AD4H/ceWdaRFY8EDEs48iL\nvq4FAEoQbncCwM8MHf5E9s/r/3PBMXD9KF/XAgAlC5/YAfAzcdGhvznD4ofNWT4t3te1AEDJ\nQrADAABQBD8pBgAAoAiCHQAAgCIIdgAAAIog2AEAACiCYAcAAKAIgh0AAIAiCHYAAACKINgB\nAAAogmAHAACgiP8HeW8R3Dwi2TsAAAAASUVORK5CYII="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# visualize the number of rides by rider type\n",
    "all_trips_v2 %>% \n",
    "  mutate(weekday = wday(started_at, label = TRUE)) %>% \n",
    "  group_by(member_casual, weekday) %>% \n",
    "  summarise(number_of_rides = n()\n",
    "            ,average_duration = mean(ride_length),.groups='drop') %>% \n",
    "  arrange(member_casual, weekday)  %>% \n",
    "  ggplot(aes(x=weekday,y=number_of_rides,fill=member_casual))+geom_col(position=\"dodge\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "id": "1b17e9f0",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:38:59.993776Z",
     "iopub.status.busy": "2022-03-29T18:38:59.992188Z",
     "iopub.status.idle": "2022-03-29T18:39:14.059361Z",
     "shell.execute_reply": "2022-03-29T18:39:14.058481Z"
    },
    "papermill": {
     "duration": 14.274969,
     "end_time": "2022-03-29T18:39:14.059508",
     "exception": false,
     "start_time": "2022-03-29T18:38:59.784539",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nOzdd2CU9f3A8e9lEwIkgMp0IYqIKGpF66AOqqi1alWwKoJbcWDdYhVx1gUu1FpH\ntVZsxV3HDwdu664bFcWFA5kBsu9+f0RxIbkAuQvfvF5/tHdPLs/z+WYcb5/cSKRSqQAAwIov\nJ9sDAACwfAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBI5GV7gHSlUqk5c+Zk\ne4qfKiwsLCoqSiaT5eXl2Z4lC9q0aZOTk1NZWVlVVZXtWTItPz+/uLg4hDBv3rwW+CrfrVu3\nzsvLq66urqioyPYsmZaTk9OmTZsQwoIFC2pra7M9TqYVFRUVFhbW1dXNnz8/27NkQdu2bROJ\nREVFRXV1dbZnWYyysrJsj0D2rUhhV1dXl+0pFiMnJ6fZztbUcnJyWuzyc3Nzc3JyQgh1dXUt\nMOxCCDk5OYlEogV+60MI9d/6ZDLZYpffMn/rw3c/9iGElrl8Vgj+FAsAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABCJvGwPsJy1uWhMho9Y\nFULeeWMzfFAAgJ9zxg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEnnZHqARioqKsj3C4iUSiWY7W5NKJBIh\nhLy8vBa4/Ly8b393ioqKUqlUdofJvNzc3Pr/bYHf+pycb/97uKCgoP7r0KLUL7nF3unVa553\nepWVldkegWYhtrCry8AcP9Ni7+Pqwy4/P78F/vNWv/YQQmFhYXYnyYr6uGmZYbfoW19QUNAC\nm77+W+9Orxne6Qk76q1IYTdnzpwGb9MmA3P8TDKZTGe2+LRv3z4nJ6eioqKioiLbs2RaQUFB\n27ZtQwhz585tgf+6t23btqCgoLq6ury8PNuzZFpubm5ZWVkIYf78+TU1NdkeJ9Nat27dqlWr\nFnun16FDh0Qi0TLv9FhRrEhhBwA/1OaiMZk8XHX9/51xfiYPCo3iyRMAAJEQdgAAkRB2AACR\nEHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAA\nkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYA\nAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2\nAACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkcjL9gAsT20uGpPJw9XU/98Z52fyoADAL3HG\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEnnZHgCApdfm\nojEZPmJVCHnnjc3wQYE0OWMHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEIkMvVds9bz3/nb59c++MbUyt/Wqa/T+w6EjtlitJIQQQnLyhPH3\nPfnKp+W5vfpsOuzo4WsWe/taAIClkZkzdqnxfzrj2W86jTj93PNHHdsr992LTzj5m5pkCOHD\niaePvf25zfY45MyRQ0umPjrquGuTGRkIACA+mQi7qrmPP/b1woPOOnLz9dfpud5GB55yYl3V\np7fPWBhS1Zfe/k6Pfcbstf3m62281bEXHrXgi4dv/XxBBkYCAIhPJsIuJ6/jgQce2L9NwbfX\nE3khhOLcnKq5T35SWTdwYNf6zYWlW/YrKXh58pcZGAkAID6ZeEBbfuu+u+3WN4Qw+7X/vvLF\nF688OnGl9X63/8rFFdNfDyH0Ls5fdMt1i/Meen1u2Pfbq9OnT587d2795UQi0alTpwxMuxQS\niUReXst9aGBOTk4LXH5ubm79hby8vFQqld1hMi8nJye01J/8+rWHEHJzc1vgt36RFvitX6R5\n3unV1tZmewSahYz+aH719GMPffD5xx9XbL7H6iGEZNWCEEKHvO/PGnbMz62dX7no6vjx4x96\n6KH6y2VlZZMmTWrwEFXLd+L05OTklJaWZuPIP5WV5bdq1apVq1bZOHKz0K5du2yPkDUFBQUF\nBQUN3y5SJSUl2R4hhCz91ufm5rrTy8aRl+Sbb77J9gg0CxkNu15HnXpRCAunv3DYUeed1bn3\nSb1ahRBm1yZLvjv5MbOmLre05f47AQCwLDIRdvM+eOqpqYU777Bp/dXiLpv+rn3Rfx7+Mn/j\n9UN4ckpFbffCb8Pu/Yradlt+/1+Bf/rTn4444ohFV2fPnt3gsYqX6+RpSiaTi/5knF1ZWX5F\nRUVlZWXDt4tLfn5+/QmbOXPmtMC/x5WUlOTn51dXVy9Y0OKe7ZSTk1N/mra8vLw5/PErK7/1\ndXV18+bNy8aRfyory1+4cGFVVVbOFULDMhF2NRVP/PWat/pve2vH/JwQQkjVvbWwtniD4qLS\nbboUXPPw019vv0v3EELNgtdeKK/eY/vvH0jXvn37RZeTyeSsWbMyMO1SSKVSdXV12Z4ia5LJ\nZAtc/qLH2NXV1bXAsKtfsp/8lrz8lrz2Fv6TTzOXiWfFlvU6rEdB1SnnX//ym1M+eOd/t19+\n4msVhfvtt2ZIFJywZ68Pbhr9yMtTvvjwzRvOuKS483ZDuzWLh60AAKxwMnHGLid/pXMuPW38\ntf+8ZMzDtfltVl2918gLztiirDCEsNbgc46sGjdh7BkzKxM9NhhwzphDvMcZAMDSydCTJ4q7\nbnLCmE0W84FE7sADjh94QGamAACImRNkAACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2\nAACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACRyMv2ALB8\ntLloTIaPWBVC4V8uz/BBAWAJnLEDAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhHeegBhk+I03UiFUhRDGXJTJgwLQIGfsAAAiIewAACIh7AAAIiHsAAAi4ckT\n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\nT50xOZ1jhUThzYdtmM4ayz8f+8jsyo0vvKy+6kIIRe0H3H31lX8+qGMIYc+np3w1/e3v8iuk\nkguqUqlU3cIQQiKnVUEizHnnzpc+La//6OYXPjNjxowGq27Ju11GaZ6xS1ZV1fTe7bg7dz+u\n/vrgSycNOu69jxYU9V5n1fwGTnACACuknLwOP7yalwiFK5UtuprIyV90uXLWg3Wp1BuXbJq4\n5Kc7mfvG3MburV7Z+j96z9K8orV2bl/0wFdPVc6a0eCxCko2XDk/rbNX895/PISwxbar/HDj\nVgcdsVUIIYTi0vazXnzo7w89+dZ7Uz/+ZNo7r//v8zlVRaUhhJBb2P3h8/ff5bR/bLrabav1\n6f/rzTbbetsd9trzt+3zGg6jJex2GaUVdqm68tLisv7/fH/y4B6LNrbtvvYGy2EAAGDFl1MQ\nQlj/pBsWnZNbpLBdWmfOfu7nfZSXCImcwnSOlchJ97XYklXJEEJBYvE1NvH47fYa+3jXftv+\nbpvNdtlix+PHbPD5oQOP+vrbj2590t+/Hnbq3XffP/nJp5+ZdNM/rxv7p+M2u/vNxwf+4FTi\nIqlkKs3dLou0wi6R2+74ddvffMOL4QdhBwBQr6j9TrmJkbVz1tlhh18v2lhb8e7Ee//XaYPi\npdvnrDfvDmHgoqt1VdPum1nZdvPtitr3XY7Harv2RiFMeuaFb8JqbRdtfOzkI26ZWXbt2F0H\nj328+07XfHz/oYs+dON3F2rmT3nlrTkdNth4yKEnDDn0hBDCOw+e3XunM449/dW3r968fuQf\nHuirl2bVX6guf34Ju11G6T7G7s9PPdD306NHXH7PzKoW9XIwAEDD8orWGt27/fu3HPDol98/\nUOy2Eb/fZ599Pkm3NX5q/vTxp/3nw++u1f3zhN/Pr0v+/sItlu+x2q526gYlBf895oSPKr8t\nnOq5zw297Lr7X1i5duG7dalU+w03XnTjhV88e8nn5SGkQggLvrp6s8022/uCVxd9dPVNfhVC\nqF1QG0Iozs2pnPWfb757yGDlzOePfOzbl4pb8m6XUbrPit1l71HJVVa9euTuVx9XtErnlYp+\n/Hfrjz76aMmfnqqdfdd11z747P9mVuZ07t5z1/0P36FfpxBCCMnJE8bf9+Qrn5bn9uqz6bCj\nh69ZnO5IAEDzMfKB8detve+gHn12H7Lrxj3bv/nY7bdMem/9Ybfsv/JSnrErXKnogl17v7nv\ngb/q0ebVx/911xPTuu9w9lWbr7J8j5XIbXfPP47suftl6681YPh+O3TKn3PXddd8Udf6qjuG\nFa9UtH2HIx+/aJej8k/YuFvxh289/7dr7u3Rqaj601cuv/XfB+49evuV/vro2Vvv9OHwzdZb\nMzln2t1/uyE3v8Po8/qFEHbdf+2zznlxg22HnrTftjVfvnvTpZd91bEgfFYbQiheacgSdnvQ\nPns2NPKSpFtRRUVFIXTZeeef/jE7Tf933gm3vt122KHH9OrS+vVHbxs/ekTFlX/frXvJhxNP\nH3v7x/uNOOrAstr/XHvVqOOqb712xNKWPQCQNSWr7v366+1OPvn8e+68/u7qgjXX7n3mdQ+e\nftCOS73D/uOeHfre1VfefNek22a16bLOgadfN3b0QYkmONZqvx/7zgO9/nTelTdfcXZVomS9\n/r/7+znj9lu7NIRw96v3jTh01N1XnHlL/iobbfzr6176cLOKv/1q4OgTDx/xh72+uPeNR04+\n9sx7Hrx10q0LWpV13mirP95x5l9261YSQuh31uQrFx58xcRHTzzinzWpVNcthv7fRTO2/PWD\nIYSQU7TE3e6x1F+xEEIilWryt/Woq/p0z72PGnDeTSPXq3/yS+rKAwa/1OVPN5230VGDBxfs\nefGle/cIIVTNeXqvoRfudfVt+3ddzAMek8nkrFmzGjxWm4vGLOfp05B33tjZs2dn/rg/l5Xl\n155xfkVFReaP+xNZWXvhXy6fOXNmBn6JGpSV5YcxF5WXl2fhuD+WnbWHUHna2TU1NVk59A+5\n08v8QZvJnd7PdezYMdsjsBjJqnmfzahdtVv7zBwu3bNjc5doyZ9bVzlttTXW2GnNRY9JTPRr\nV1gzZ37V3Cc/qawbOLBr/dbC0i37lRS8PPnLpVwKAEAzk1PYNmNVF9L/U2xp6ZJeXGXJZywK\n2m01btxWi67WzH/3hunzVxu+TvWCf4cQehd//7o16xbnPfT63LDvt1dvvPHGF198sf5y69at\nzzvvvAbnTDZ4iyaQk5PTrl27bBz5p7Ky/KKiooKCgmwc+UeysvYQQtu2bRu+UdPLyvLz8/Ob\nw09+tr71rVu3bg4na93pZV4zudP7iQZPsrRY0+7apd+BzyzhBoXtBnw57e6MzdPU0g270aNH\n/+h6qnb6h2/fffs9sxJdR1/dcG8t8vFLD1x+2Q01aw4atWO32o8XhBA65H1/1rBjfm7t/MpF\nV6dOnfrCCy/UXy4rK8vP/+lLF/5cVfqjLD+JRCKd2TIgK8vPzc3Nzc3NxpF/JCtrDyG05G99\nTk5OTk72HxObrW99Xl6zeKaXO73MayZ3eqRp9d3vn717tofIoHTvmM4888yfbxx30X+3W3vA\nuMteHjV8359/9CeqZ0+54YrLH3x11oA9jzj3j9sWJRLlBa1CCLNrkyXf/YbMrKnLLf3+P4P6\n9OlTW1tbf7m4uLiqKlt34A1IpVLV1dUN3y5StbW1dXUt90Vwmu2PZQYkk8nm8CCzbKmpqUkm\ns3W6MMvc6bXkOz2auWX6L85Wq/S/bsyGfUaOfWLu+QPaFS7hluUfP3r8CVfmrj/owuuGrtPx\n25djzm+9fghPTqmo7f7de6W9X1Hbbsvv/+Y7ZMiQIUOG1F9O98kTS7mUZZJMJpvDQ8hDlpZf\nVVXVHB5HnJW1hxDmz5/fHP4el5Xl19TUNIef/Gx96xcuXNgcutadXuY1kzs9WKxl/TNKcbfi\nRCJ3neIlnZNPJReee/L4wu2OGX/GoYuqLoRQVLpNl4Lch5/+9h00aha89kJ59Ubbd1rGkQAA\nWqZlOmOXrJkx9s+v5Zf067TE99ld+PWtby+sGb5+8csvvfT9gVutteF6pSfs2evEm0Y/0vmk\n9cpq7r3qkuLO2w3tVrIsIwEAtFjpht3mm2/+s23JL95//eOZlZucfuWSP7f8g2khhBv/cu4P\nN7btfto/rtpsrcHnHFk1bsLYM2ZWJnpsMOCcMYdk/5HYAAArpmU5Y5fTff1td9tuvwtH9V/y\n7Tptee69W/7CxxK5Aw84fuAByzAFAAAhhPTD7rnnnmvSOQCA5qPpnh/Tpk22nvLUIiwp7O65\n55409/L73/9+eQwDAMDSW1LY7bbbbmnupTm83AMAsBwVnDNque+z+vRzG74Ry2BJYTd58uRF\nl5M1X/9532EvVnQ58OhDt92sT2lu5ftvPXfNhVd80X3PyQ9c2uRjAgDQkCWF3YABAxZdfvzw\nPi8u7Pnkx//t3/7bFyIeuNPuh44Y/pvO/fYctf871/+2accEAKAh6b66yEn/fL/Hflcvqrp6\necXrjj147am3n9AEgwEA0Djpht0HFbU5BYu7cU6oq/pseU4EAMBSSTfs9l6p+IObT55W9aO3\nPa6r+uS0698vXnlIEwwGAEDjpBt2o675Y9WcJzboM2jcLXc9/+o777z231i50YQAACAASURB\nVHtuvXyn9fs+Mrtyn6tPadIRAQBIR7ovULzqrtc+Ni5v75OuPW7opEUbcwtWOnLco1ftumrT\nzAYAQCM04i3Ftjn2qukHnvjw/ZPenDq9Jqeo61rrb7/Tb1ct+X4PA3r1fOLd95tgSACAptI+\nP3f3t7+5vmdZtgdZDhr3XrH5bVbfZZ9DdvmFj3728bRlngcAgKWU7mPsAABo5oQdANAs1Mx/\n66Q/Dlq7a2lx6SrbDTnhjfk19dsrvn72iN237lRakldYvEafrc7797v126c9dM3Ov+rdvnVh\nx65r/v7wC+bVpUIIIVWVSCTO/bR80W67FOYd9P7sJewnJsIOAGgGUtWH9NvihnfK/nLjfx69\n85qV/3f9b/qfWv+RU7bYeeL03tff++hLT08aOTD55302/aiyrnreU313GRF2PO6BJ5//15Un\nvHzT6Ttd8faSj7DY/TT9wjKqcY+xAwBoCrPeOfHmD6snz7pp63YFIYS+j36zy77//KI62bkg\nZ/VDT71+2NE7r9QqhNCrx2kjx+3y6oLqDuUPldclDzty3806F4eN+z0ysfP7xR2WfIjF7meN\nolYZWF3GCDsAIPs+u/fZorLf1lddCKF1l0Mef/yQ+ssj/3TE4/dOvPDNKdOmffja0/+p31jS\n7bj9fnXjHquvMWDQb7fcYouBg3b7XZ9OSz7EYvcTGX+KBQCyL1mVTOQU/Xx7XdWnu/TsNnjM\nbXNzO2y1y36X//vW+u05eR1veeGzNx67cddfdXvnsZsHbtht0CmTfv7pIYTKZGoJ+4mMM3YA\nQPZ13aVv5dkTX5pfs0lJfghh4Ve39NjwpBvfnrbJJ8c/+HHlF5X3rZKfE0JY+PW3QfbVM5ee\nf1f1uItPWXeLnY4N4e1rft3vxJPCBa/Wf3RWTbL+wsKv/z27NhlCmP3u4vcTGWfsAIDs67jh\nFb9bJbnz9ofe//gLrzzz4JG/Pa6yZNcdywoLO/wqlay+eMLkjz/76NmH/z5k25NDCG9P/Tpv\n5fLLLjl16Dk3Pf/qG/+dfPf5V01pt85eIYSQKNysbeGEQ857ecrHbzz34IHbHZ6TSIQQfmk/\nkT17whk7ACD7Erklt7/x2AmHnHbsHwfOqGu38fYHT756TAihTbcTH7pw2jGnDb5yXt4Gm243\neuJbnfZf/6wt+wyaNevBS745+cqTtx49q90q3Tfe9uDJV59Yv6t7/++KIQeft9V6F1fUJbcY\nfuXgr09a8n6yuezlrXFhN+XR2297+LlPvp619V+uGZL/7H+n9x3QZ+VFHx097vLlPR4A0FIU\ntt/0iomPXPGz7TuceNWUE69adHXHFz75a/2lP12x459+fvOwUv9DHn3jkFSy4qtZqU4di0MY\nseT9zKqJ57Rd+mGXGj98yxE3PVt/pfjPl+88//Jt+t2/9cFXPHLtiLxECCHsf9gRTTIjAEAj\nJXJadeqY7SEyLt3H2E29dY8RNz273Yhx/3v/8/otZT0vPO/QzZ+47qhdr4nwhZsBAFY46Ybd\nOcdPar/uKY9ceWzftbrUb8kr7nXKNc+ctX6HJ0af3WTjAQCQrnTD7o5vKnoM++PPt+8+dM3K\nmfct15EAAFga6YbdqoW55e/P+/n22W/NzS3sslxHAgBgaaQbdqf1X/mDfwx9/pvKH25cOP2x\n4bd/2LHfyU0wGAAAjZNu2O1x+19XTXwyYI0NDzthTAjhrQk3nH3isN49d/gk2fmKf+/dlBMC\nAJCWdF/upNVKO736v3sPP+z4v106OoQw+fTjn0jkrrfN3nddOX6Xzq2bcEAAIBuqTz832yPQ\naI14geK2PQf987FB18/46K2p02tzW3XruV630sKmmwwAyKK2L7++3Pc5b+O+y32f/FC6Ybdg\nwYJvLxWvvO769e82UbtgQW1efmFhgfclAwDIvnSbrKSk5Jc+lJNX3HWNHv0H7HDY8aO271W6\nnAYDAKBx0n3yxDVXX75Ru8JETkG/bX936Ihjjj3qiN0HblKYk+i40V5HHT50s3VXevof43ZY\nf43rPpjbpOMCAPBL0j1j96uZ/z6qqtNtr7w0eIPv33dt1ht3/GqzA0rOe+9fO3Stnjdlv96b\njNr71kNeObJpRgUAYEnSPWM38qIXeuz7jx9WXQih/fp7/uOA1cbt/6cQQkHbdS68atM57162\n/GcEACAN6YbdWwtrirsv5mVNWq/aunL2/9VfbtW1dV319OU2GgAAjZFu2B3UtWTKVWd9WlX3\nw43J6uljxr1T0mVY/dUHz3mjqP1Oy3c+AADSlO5j7E6+68yrNzmxd8+tjjh8yCa9VisMVR9P\neeVf11713MzcS148vWru43vsfPADz0z73TUPNum4AAD8knTDrsOGf5ryePvhR5120ahjF20s\n7bnVtY9NOHjDDgu+ePupqQWHX3Dn1Yf1apo5AQCW1cKvrm/d6eCPKmtXL8zN9ixNohGvLdxl\nq2EP/2/YF++/+tq7Hy+sy+u0xrr9+/bITS2cV76wbecj530xoummBACgQY1+04jOPft17tlv\n0dVPJ+2+5q7v1lR+vFynAgBarLqaZG5+us8CWO6f/otqF87JK27ub8SQ7rpTdfOvOHqfTXr3\nXOPH1h40KZHXpklHBABagi6FeadPuqFfpzaFefmd1ur/1xdmvPT3E3t1Liss6dh/95Hf1CTr\nb5asnn7+iD036NmtqKTD+gP2uunZLxv16SGEr5+/cfsNV29VUNRlnf6jb355ybttn597xSef\nHr/XNl3XGJrBL8ZSSjfsXh3zm2OunDCvdI21O9dOmzatV98NN+jbK2/m9ET7bcbf81CTjggA\ntBCX7n7J4Tc88t6bz+zZ5sMjt1p/jwmpGx9+4YnbR79z3xVDJn5Uf5tRAza66InESZfd8uyj\ndx6+eTho67X+9v7c9D89hLDrLucNOPbSxx6955itC8YM+9Wo575a8m7vOHindjud8MRzf83s\nF2NppPun2NOueKtDn3Pee3ZUqm7+miVlW15586jubSq+fqLPGjvN77KY17cDAGisjcbdedhO\n64QQTh+/6fgtHvrPxAvWL84LfXue1P30256aEYb0mP/52L/8d8bjs/4xoLQwhLBR/wE193QY\nc+RTB0/aJZ1Prz9K/+sm/XlIjxDC5lvtMO/ZDtcePOHU/0suYbdfr3HZGcO3zdKXpHHSPWP3\n1Lzq1YfsEkJI5Jbsv3LxY6/MDCG0WnnAzcNWP2fP65pwQACgxVhli2/f4yq/tCi3cNX1i789\nA9UhLyeVTIUQ5rz7UCqV/E1ZUeI7x707q/zDKWl+er2jduy26PK+h/ac/9m/lrzbtYb1bsI1\nL1fpnrEry0vUlNfUX+7frfW/7vk8/H71EMJqe3Sb87exIZzURPMBAC3VYk4/5bdrlZNXOnfO\nZ4kfbEzkFKT56T//QEH7gkRO/pJ327b9YvffHKV7xu7grm0+uPGC+nee6L5r188e+PbPzF8+\n+lVTjQYA8GPt1jwkVTf32uk1rb9VfObvdzj0Hx82aidXPfL9O6Dedsk77dbef7nstjlI94zd\nYTccMmabi3t0XHXKjE96DD144alHbD58lT3WqLnkkjfbr3dxk44IAFCvqP3OYwd2PXXLXUsu\nP3XztcsmXX/CZc98/sC/V2/UTu4bOvAvlWO3W6v1k7ecO/qNeePe/H1R+7Jl321zkG7YdR5w\n4asTO5917X05idC682G3jbxj33EXP59Kte2xwx0PHdakIwIALHL0/S8vPObQ847c+8uqwl79\ntrnlybsHlhWm/+m5BZ0fvnSvk8865MxPK9facOOL7nzzmHXLln23zUSaYZesqqrpvdtxd+5+\nXP31wZdOGnTcex8tKOq9zqr5iSV/LgBAw6ZX1S663GHdiTUV33/oiPdnHfHd5Zz8lU+9+u5T\nr16aTy9e5aDaqoNCCC8efv5PPv2Xdjurpq7RK8metB5jl6orLy1uNfBfU3+4sW33tTfopeoA\nAJqLtMIukdvu+HXbf3jDi009DQAASy3dZ8X++akH+n569IjL75lZtSKdkAQAaDnSffLELnuP\nSq6y6tUjd7/6uKJVOq9U9OM31/3oo49+6RMBAMiMdMOuqKgohC4779ylSacBAGCppRt29913\nX5POAQDAMko37OpNefT22x5+7pOvZ239l2uG5D/73+l9B/RZuYkmAwCgUdIPu9T44VuOuOnZ\n+ivFf7585/mXb9Pv/q0PvuKRa0fkedETAIjLvI37ZnsEGi3dsJt66x4jbnp2uxHjLh251wY9\nu4YQynpeeN6hM0+99qhd+233wBG9mnJIACCj2rRpk+0RWBrpvtzJOcdPar/uKY9ceWzftb59\n/kReca9TrnnmrPU7PDH67CYbDwCAdKUbdnd8U9Fj2B9/vn33oWtWzvS8CgCA7Es37FYtzC1/\nf97Pt89+a25uoddAAQDIvnTD7rT+K3/wj6HPf1P5w40Lpz82/PYPO/Y7uQkGAwCgcdINuz1u\n/+uqiU8GrLHhYSeMCSG8NeGGs08c1rvnDp8kO1/x772bckIAANKSbti1WmmnV/937x9+lfO3\nS0eHECaffvyZl/yjzWZ73fXq63/o3LoJBwQAID3pvtxJeV2qbc9B/3xs0PUzPnpr6vTa3Fbd\neq7XrbSwSYcDACB96YbdSh3X+sPQYcOHD99+wzU2WWmNJp0JAIClkO6fYgesFW674syB/bp3\n23D7My67ders6iYdCwCAxko37B5+cerM9/87/pzj10q+e/bI/dZeqcOAPxx20/3PVySbdDwA\nANKVbtiFEMp6/OqIURdPfv2zL956+pLThlW/edfw323eofO6B574l6abDwCANDUi7Bbp1HuL\nkWOueOL5/146YsfqGVNuvPiU5T4WAACNle6TJxap+GrKvXdOnDhx4n2Pv1qZTLVbvd/gwUOa\nYjIAABol7Zc7+eyNuyZOnDhx4oNPv1WTSrVaZd09jzpzn332GbTZ2okmHRAAgPSkG3alq26Q\nTKUK2q2+68En7TNkyK7bbJgv6AAAmpN0w27HfY8eMmTIHoM2a53zo6BLJReWLwht2xQ3wWwA\nADRCumH3n1suW+z2zx7Zfc1d362p/Hj5jQQAwNJIN+xSdfOvHHnI3x99aWZF7Q+3f/nJx4lW\nvZtgMAAAGifdlzt5dcxvjrlywrzSNdbuXDtt2rRefTfcoG+vvJnTE+23GX/PQ006IgAA6Uj3\njN1pV7zVoc857z07KlU3f82Ssi2vvHlU9zYVXz/RZ42d5ndp3aQjAgCQjnTP2D01r3r1IbuE\nEBK5JfuvXPzYKzNDCK1WHnDzsNXP2fO6JhwQAID0pBt2ZXmJmvKa+sv9u7X+/J7P6y+vtke3\nOR+MbZLRAABojHTD7uCubT648YJPq+pCCN137frZA3+t3/7lo1811WgAADRGuo+xO+yGQ8Zs\nc3GPjqtOmfFJj6EHLzz1iM2Hr7LHGjWXXPJm+/UubtIRm7miQYPDU89n+KAz+qyT4SMCAM1f\numHXecCFr07sfNa19+UkQuvOh9028o59x138fCrVtscOdzx0WJOOCABAOtINuxDCBrsfd+fu\nx9VfHnzppEHHvffRgqLe66zqvcUAAJqDRoTdT7TtvvYGy3GQNBQVFWX2gM1Xs/pS5OXlNat5\nMqyoqCiVSmV7iuzIzc1tyd/6goKC3NzcbE+RHYlEoiV/65vnnV5lZWW2R6BZWPqwy7x0fpHq\nMjBHM/BLX4qsLD8/P785/POWrW99YWFhlo78I1lZfjMJu2x96wsKCppD02dl+c0n7Frynd5P\nCDvqrUhhN2fOnAZv0yYDczQDv/SlyMryKyoqKioqsnHkH8nWt37u3LnN4V/3rCy/urq6vLw8\nG0f+kWx96+fPn19TU5Olg38vK8tPJpPp3CFnQEu+04PFSvflTgAAaOZWpDN2AJBdRYMGhxdf\ny/BBvcQV6XPGDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEnnZHgCAFUnRoMHhqeczfNAZfdbJ8BFh\nBSXsWCZFgwaHF1/L8EHdxQPAYvlTLABAJIQdAEAkhB0AQCSEHQBAJDx5AlgaRYMGh+deyvBB\nPW8GYMmcsQMAiIQzdrCUigYNDpOfyfBBnbJqJooGDQ6vvpnhg/ruAw1yxg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEnkZPt5NRxxQNOaaISu1+m5DcvKE8fc9+cqn5bm9+mw67OjhaxZn\neiQAgDhk8oxd6v2n/nbX9Dm1qdSiTR9OPH3s7c9ttschZ44cWjL10VHHXZvM4EAAADHJ0Omx\nr58bd/IVT8+cX/2jranqS29/p8c+F++1fY8QwloXJvYaeuGtnw/bv2vrzEwFABCTDJ2xK11v\nr1FjLrj4Lyf/cGPV3Cc/qawbOLBr/dXC0i37lRS8PPnLzIwEABCZDJ2xK2jbda22oa666Icb\nqxe8HkLoXZy/aMu6xXkPvT437Pvt1enTp8+dO7f+ciKR6NSpU2ambf7y8lr0IxFb8vJb8tqD\n5bfg5bfktYf0ll9bW5uBSWj+svmrkqxaEELokPf9WcOO+bm18ysXXR0/fvxDDz1Uf7msrGzS\npEkN7rNqeQ/ZPJWWli52e0tefktee2jZy28haw8te/l+8hu8zTfffJOBSWj+svlyJzkFrUII\ns2u/f77EzJq63FYF2ZsIAGAFls0zdvmt1w/hySkVtd0Lc+u3vF9R227L7/+75Mgjj9x332//\nLptIJObMmdPgPls1eIso/NKXoiUvvyWvPbTs5beQtYeWvXw/+dkegRVGNsOuqHSbLgXXPPz0\n19vv0j2EULPgtRfKq/fY/vsH0nXp0qVLly71l5PJ5KxZs7IzaPPTwh9L0ZKX35LXHiy/BS+/\nJa89tPjl0yhZfeeJRMEJe/b64KbRj7w85YsP37zhjEuKO283tFtJNkcCAFhhZfl5RmsNPufI\n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\nRU5ErkJggg=="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# create a visualization by average duration\n",
    "all_trips_v2 %>% \n",
    "  mutate(weekday = wday(started_at, label = TRUE)) %>% \n",
    "  group_by(member_casual, weekday) %>% \n",
    "  summarise(number_of_rides = n()\n",
    "            ,average_duration = mean(ride_length),.groups='drop') %>% \n",
    "  arrange(member_casual, weekday)  %>% \n",
    "  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +\n",
    "  geom_col(position = \"dodge\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "id": "6f54d83f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:39:14.486377Z",
     "iopub.status.busy": "2022-03-29T18:39:14.484901Z",
     "iopub.status.idle": "2022-03-29T18:39:27.886417Z",
     "shell.execute_reply": "2022-03-29T18:39:27.885509Z"
    },
    "papermill": {
     "duration": 13.614451,
     "end_time": "2022-03-29T18:39:27.886567",
     "exception": false,
     "start_time": "2022-03-29T18:39:14.272116",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\nAAAiIewAACIh7AAAIpHT1gO0jdzc3OwumEwmW2jlpqmfJ5lMtpN5EolEaH/zpFKp9jBP/TCh\n3cyTLe1tX8zTuGzN03Bn2EzZmueXc+dTXV2d3QX5mfqFhl1JSUl2F2wIqayv3DT186RSqXY1\nT25ubiqVautZQvjxvjUvL6+d3NfXKygoyM/Pz8pSNVlZpXkW/rNnnkW153maI1thl915fgl3\nPrNmzcrugvxM/ULDLuu/AMXFxYWFhXV1de3kV6u0tDQ/P7+6unrOnDltPUsIIZSVleXk5FRW\nVs6bN6+tZwkhhM6dOyeTyfLy8vLy8raeJSQSiS5duoQQ5s+fX1lZmZU1S7OySvMs/LtgnkW1\n53mao7Q0O3uTrXnc+fBL4zl2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYA\nAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2\nAACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACRyGnrAYAQ\nQkiMf6GZK0zvu0ZWJgHg58sROwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7\nAIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgI\nOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBILFXY1X095cP6UxXTXj3n\n5CHHDv3zE1PmtsRYAAAsrZwML1f1/Ut7b77z2I+Xr5r/brpm1u/X2vKfM8pDCNddcf0tk9/e\nZ6WSlhwSAIAly/SI3V277fXAe1UHnHBMCGHaxOP/OaN8yGMfzPrkufVzp5408O6WnBAAgIxk\nGnYXvjJt5V3H3HDeESGEt86fkN9x8yt36F22ymZX7rvajLevaMkJAQDISKZh93llTddNetSf\nvvWV6V36nZAKIYRQ3LO4pvzjlpkNAIClkGnYbdoh/6tH3wwhVM5+4s7pC9Y/ff367a899GVu\nUZ+Wmg4AgIxl+uKJcw9cfbORB+1y6MScl29L5HS+cIsVaio+uuHyy4974Zvltrq8RUeE9q/0\n0uHNuXplCGGHgVmaBYBfrkzDbuNLnh721e8uvHlUdaLwoCueX6c4d95XDx115uiS7pv//Z4/\n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\n19XVzZw5M7v7UlxcXFhYWFdXN3v27Oyu3DSlpaX5+fnV1dVz5sxp61lCCKGsbDE/o6W18Pe2\ntPnLNZt5GmeexrXbedrDMOG/vz/NkfU7n2bq3Llz8xdpJ3/R0D615RsUFy23fahbMG5mbcEP\n8u+44JxrnvmmaNl9x44dO3bs2PvHXJLM6TT2Rz0LUgVlv+2Wl/rH89PqV6ie/+Yrc6vW32b5\n2R9cc8ihQ76pqvtx7bpnpy4oW2v1tto1AIDW15Zhl1e64aHrdfn7qeePe27ip1MmP3j9aQ+/\nP2OrTZdt7DqJvJP27PPRLcOenDj56ynv3HT25UUrbL1/95IOPQd2WfDtqcOuf/WdyR++++Zd\nI0+ZML908KHCDgD4BWnLh2JDCDufPaLyL1ffM/riWdW53Xv2O+GioeuVLOFdhVcbeP5RlSPv\nGnH2jIpEr3W3PH/4YckQQk7X86459+bRt486/8yKVGnP3n1PGTGs/5KWAgCISauGXSqv+9ix\nYxfekkh13PPIoXseufjL5xT2Wfi9Thqus+0BJ257wP9uzu+09hGnX3hEtmYFAPi5acuHYgEA\nyCJhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEImcth6An4fSS4c35+q1IYQdBmZp\nFgBg8RyxAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiIRPngCg\n/fKxN7BUHLEDAIiEsAMAiISHYrMmMf6F5i8yve8azV8EAPhlcsQOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASOW09QNsoLi7O\n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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# visualize number of rides for each month between members and casual riders\n",
    "all_trips_v2 %>% \n",
    "  mutate(month = month(started_at, label = TRUE)) %>% \n",
    "  group_by(member_casual, month) %>% \n",
    "  summarise(number_of_rides = n()\n",
    "            ,average_duration = mean(ride_length),.groups='drop') %>% \n",
    "  arrange(member_casual, month)  %>% \n",
    "  ggplot(aes(x = month, y = number_of_rides, fill = member_casual)) +\n",
    "  geom_col(position = \"dodge\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 25,
   "id": "bc38a5f6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:39:28.321093Z",
     "iopub.status.busy": "2022-03-29T18:39:28.319506Z",
     "iopub.status.idle": "2022-03-29T18:39:28.618459Z",
     "shell.execute_reply": "2022-03-29T18:39:28.617429Z"
    },
    "papermill": {
     "duration": 0.516857,
     "end_time": "2022-03-29T18:39:28.618589",
     "exception": false,
     "start_time": "2022-03-29T18:39:28.101732",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nO3de4CVc/7A8e+Z+0xTTTXRXbpQCYUli82tzTV3skhZRMh1ZUWS2F23bELWblhs\ntSv3tax7COu6tja5RgoxKd1mauac3x+T0f6ozoxmpr69Xn89lzPP+UzG6d0z53lOIpVKBQAA\nNn4Z9T0AAADrh7ADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIhEVn0PkK5UKrVw\n4cL6noJNS2ZmZmFhYQhhyZIlFRUV9T0OsAHJycnJz89PpVLffPNNfc/CJqdJkyZr2rUxhZ2/\nWaljiUQiIyMjhJBMJv34AatLpVIZGRn+bmJD41exAACREHYAAJEQdgAAkRB2AACREHYAAJEQ\ndgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACR\nEHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAA\nkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkciq7wEiMXTo0PoeAai2sWPH1vcIAOuT\nM3YAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAA\nkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYA\nAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2\nAACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQ\ndgAAkRB2AACREHYAAJEQdgAAkRB2AACRyKqbp1nxzbt/HPunaf/5oDSzQbstux1x6hm7bVEY\nQggh+eykmx+e+sacxZlduu888KxBHQrqaCQAgMjUzRm71M3njZj2VYszLrnyN8PP7pL5zrUX\nDPtqZTKE8OGUS8ZMfqnX4adcds6Awg+eGn7urck6GQgAID51EXZli555ev6yX14+ZNdtt+68\nzQ4nXfSrirI5k79cFlIrrp88s+Oxo47ad9dtdtzj7KvPXPrZ4/fMXVoHIwEAxKcuwi4jq/ik\nk07apWHOqvVEVgihIDOjbNHUT0or+vRpXbk5t2j3noU5rz/7eR2MBAAQn7p4Q1t2g+0OPXS7\nEMLXb73yxmefvfHUlObbHHzCZgXL570dQuhWkF31yK4FWY+9vSgct2p1+vTpn3++qvOys7N3\n2GGHOpgW2HTk5ubW9whsrLKyskIIiUTCTxF1LJVKrWVvnV6p8MULTz/2/tyPP16+6+HtQwjJ\nsqUhhGZZ3501LM7OLF9SWrU6adKkxx57rHK5SZMmTzzxRF1OC0SvYcOG9T0CGz0/RdSxioqK\nteyt07Drcuavrwlh2bx/DT7zqstbdruwS34I4evyZGFmZuUDSlZWZBblrPUYAAD8sLoIu2/e\nf/75D3IP7Ltz5WpBq50Pbpr398c/z95x2xCmzlpe3jZ3Vdi9t7y88e5FVV84evTo0aNHVy4n\nk8mvvvqqDqYFNh1eVaixvLy8wsLCVCpVUlJS37OwySkuLl7Trrq4eGLl8uf+MH5M5f1NQggh\nVTFjWXlBu4K8or1a5WQ+/sL8VQ9b+ta/Fq/YYd8WdTASAEB86iLsmnQZ3DGn7KLf/On16bPe\nn/nvyWN/9dby3OOP7xASORcc2eX9O0Y++fqszz6cPmHEdQUt9xnQprAORgIAiE9d/Co2I7v5\n6OsvvvnWv1w36vHy7Ibt2nc557cjdmuSG0LodMzoIWU3TBozoqQ00XH73qNHneIzzgAAaqaO\nLp4oaL3TBaN2+oEdicw+J57f58S6mQIAIGZOkAEARELYAQBEQtgBAERC2AEARELYAQBEQtgB\nAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELY\nAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC\n2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBE\nQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEA\nRELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgB\nAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELY\nAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC\n2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBE\nQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEIqu+B6iG3Nzc\n+h4BiIpXFWosKysrhJBIJPwUUcdSqdRa9m5MYVdQUFDfIwBR8apCjSUSicoFP0XUsWQyuZa9\nG1PYff311/U9AhAVryrUWF5eXmFhYSqV8lNE3SsuLl7TLu+xAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIhE\nVt08Tar86/tvu/Uf0/5dUprRsm3nfiec1rdnixBCCMlnJ9388NQ35izO7NJ954FnDepQUEcj\nAQBEpo7O2P3zqgvuee6LfoOG/u6KYXt3LLt55BkPzFkSQvhwyiVjJr/U6/BTLjtnQOEHTw0/\n99Zk3QwEABCdujg9VlE2Z/zrX/W+6tqDt2kSQujcZdvP/nXMAzdPP/SqHa6fPLPjsdcetW/H\nEEKnqxNHDbj6nrkDT2jdoA6mAgCITF2csasonb3Fllse0KHRtxsSPRvnrly4pGzR1E9KK/r0\naV25Nbdo956FOa8/+3kdjAQAEJ+6OGOX03iPG27Yo2p15ZJ3JsxbssWgrVcs/VsIoVtBdtWu\nrgVZj729KBy3anXq1KkfffRR5XJubu7BBx9cB9MCm478/Pz6HoGNVVZWVgghkUj4KaKOpVKp\nteyt6ysVPn7t0bG/n7Cyw/7D92tT/vHSEEKzrO/OGhZnZ5YvKa1a/ec///nYY49VLjdp0qR/\n//51PC0QtwYNvPGDH8tPEXWsoqJiLXvrLuxWfD1rwo1j//Hmgt5Hnn7lL/bOSyQW5+SHEL4u\nTxZmZlY+pmRlRWZRTtWX5OfnN2q06he4DRs2XHuiAlSXVxV+jEQiEfwUUec2iDN2iz9+6vwL\nxmVuu//Vtw3YujivcmN2g21DmDpreXnb3FVh997y8sa7F1V91fDhw4cPH165nEwmS0pK6mZa\nYBPhVYUay8vLKywsTKVSfoqoe8XFxWvaVRcXT6SSy64cdnPuPkNvHnFqVdWFEPKK9mqVk/n4\nC/MrV1cufetfi1fssG+LOhgJACA+dXHGbtn8e/67bOWgbQtef+217544v1OPbYouOLLLr+4Y\n+WTLC7dpsvKhm64raLnPgDaFdTASAEB86iLsFr8/O4Rw+++uXH1jo7YX331Tr07HjB5SdsOk\nMSNKShMdt+89etQpPuMMAKBm6iLsWux+5UO7r2FfIrPPief3ObEOpgAAiJwTZAAAkRB2AACR\nEHYAAJEQdgAAkRB2AACRqN5VsQs+/fDLpSu/v33rrbdeT/MAAFBD6YZd6VdPHrH7MY/OWvCD\ne31SHgBAvUs37P5wyAn/eG/xQadftN927bMStToSAAA1kW7YjX71yw7H3Pfwzf1qdRoAAGos\nrYsnUhWLv1xZscUx29X2NAAA1FhaYZfILNyzKO/DO16r7WkAAKixNG93kpj0yBUr/nH8wCvu\n/GJpee1OBABAjaT7HrsjL3pw85bZd44Y+OfLftm0RYv8zP+5gGLOnDm1MBsAANWQbtgVFxcX\nF++7RY9aHQYAgJpLN+zuv//+Wp0DAIAfqXqfPLFs7lv3PvjEfz+ct6wiq2WHbX5+6JE7ti2s\npckAAKiWaoTdlBH9j7vyr2XJ7z5kYvg5px01/J7Jo46ohcEAAKieNK+KDR/97bgjr5i8We+T\nJj/xytz5JV9/Oe/Vp+/95Z6b//WKI0+4b3ZtTggAQFrSPWN37TkPFbYe+M6TtxVkrLoedqe9\njtix9/7JLVr89azrwuE31tqEAACkJd0zdpO+XLbVqWdXVV2lREbB2WduvfzLibUwGAAA1ZNu\n2BVmZJR+Ufr97aVflCYyXT8BAFD/0g27czo3fv/PQ177umz1jSsWvXHmH99t3OnsWhgMAIDq\nSfc9doPuHXXZNmft1n77k84ctNt2nfLC8g/+M+2OcRPeXZYz9m+DanVEAADSkW7YFW095L9P\nZB0/5OLxV100/tuNTbf+2U033XVal6JaGg4AgPRV4z52bfY69dmZp3z6zuszPphXFnJbdei2\nQ9e26f4qFwCAWla9T54IIdGmy05tutTKKAAA/BhrC7uePXsmMnLfeP3lyuW1PPLNN99cz3MB\nAFBNawu7wsLCREZu5XJRkTfSAQBs0NYWds8//3zV8jPPPFP7wwAAUHPpXvyw6667Xvvpku9v\n/3za0D32PmG9jgQAQE2s4+KJbz56/7MVFSGEl19+ucPMmbOWNvrf/anpf5867fnZtTUdAABp\nW0fYTdlvl5PeXVC5/Jef7/yXH3pMo/ZnrO+pAACotnWE3U9HXT9+YWkI4bTTTut9xZhjm+f/\nvwdkZDfc9Ygja2s6AADSto6w2/qYE7cOIYQwadKkQ086eXCrwv/3gFRy2eKl5SHk1M54AACk\nK90bFK/pqthPnzysQ793VpZ+vP5GAgCgJtINu1TFknHnnHLnU6+VLC9fffvnn3ycyO9WC4MB\nAFA96d7u5M1Rew4dN+mboi23alk+e/bsLtv12H67Llkl8xJN97r5wcdqdUQAANKR7hm7i2+c\n0az76HenDU9VLOlQ2GT3cX8e3rbh8vnPdd/ygCWtGtTqiAAApCPdM3bPf7Oiff+DQgiJzMIT\nNit4+o2SEEL+Zr3/PLD96CNvq8UBAQBIT7ph1yQrsXLxysrlXdo0mPvg3MrlLQ5vs/D9MbUy\nGgAA1ZFu2J3cuuH7t/92TllFCKFtv9afPvqHyu2fP/VFbY0GAEB1pBt2gyecsvzL+zoWt/uo\ntKLjgJOXzb9r10EXXjPq3IOum950m2G1OiIAAOlI9+KJlr2vfnNKy8tvfTgjERq0HDzxnHuP\nu+Hal1OpRh373vvY4FodEQCAdCRSqVQaD0uWla3MyMnNTny36Zs57360NK/b1u1W31h7ksnk\nggUL6uKZamTo0KH1PQJQbWPHjq3vEdhY5eXlFRYWplKpkpKS+p6FTU5xcfGadqX1q9hUxeKi\ngvw+f/1g9Y2N2m61fZc6qjoAANYprbBLZDY+v2vTDye8WtvTAABQY+lePHHp849uN+esM8Y+\nWFJWUasDAQBQM+lePHHQ0cOTm7e75ZzDbjk3b/OWzfOy/6cIP/roo1qYDQCAakg37PLy8kJo\ndeCBrWp1GgAAaizdsHv44YdrdQ4AAH6kdMNu0aJFa9nbuHHj9TEMAAA1l27YFRUVrWVvejfD\nAwCgFqUbdiNHjvyf9VT5vA//+8DkBxckWo+85ar1PhYAANWVbthddtll3994wzWv7LNV7xt+\n//rwQcet16kAAKi2dO9j94PyN9/ltlE9vvr3mOcWla2vgQAAqJkfFXYhhII2BYlE5tYF2etl\nGgAAauxHhV1y5ZdjLn0ru7Bni+wfG4gAAPxI6b7Hbtddd/3etuRn7739cUnpTpeMW78zAQBQ\nA+mG3Q/JaLvt3ofuc/zVw3dZb+MAAFBT6YbdSy+9VKtzAADwI60t7B588ME0j3LIIYesj2EA\nAKi5tYXdoYcemuZRfPIEAEC9W1vYPfvss1XLyZXzLz1u4KvLW5101ql79+pelFn63oyXxl99\n42dtj3z20etrfUwAANZlbWHXu3fvquVnTuv+6rLOUz9+ZZemuZVb+hxw2KlnDNqzZc8jh58w\n808/r90xAQBYl3TvP3fhX97rePwtVVVXKaug65iTt/pg8gW1MBgAANWTbti9v7w8I+eHHpwR\nKso+XZ8TAQBQI+mG3dHNC97/87DZZRWrb6wo++TiP71XsFn/WhgMAIDqSTfsho//RdnC57bv\nvv8Nd93/8pszZ771yoP3jD1g2+2e/Lr02FsuqtURAQBIR7o3KG7X79anb8g6+sJbzx3wRNXG\nzJzmQ2546qZ+7WpnNgAAqqEaHym219k3zTvpV48/8sT0D+atzMhr3WnbfQ/4ebvC747Qu0vn\n5955rxaGBABg3ar3WbHZDdsfdOwpB61h76cfz/7R8wAAUEPpvscOAIANnLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiET1Pnli1lOTJz7+0ifzF/zsd+P7Z097Zd52\nvbtvVrV35A1j1/d4AACkK/2wS908aPcz7phWuVJw6dgDl4zdq+cjPzv5xidvPSMrEUIIJww+\nvVZmBAAgDen+KvaDew4/445p+5xxw7/fm1u5pUnnq686ddfnbjuz3/h3am08AADSlW7YjT7/\niaZdL3py3NnbdWpVuSWroMtF41+8fNtmz428otbGAwAgXemG3b1fLe848Bff337YgA6lJQ+v\n15EAAKiJdMOuXW7m4ve++f72r2csysxttV5HAgCgJtINu4t32ez9uwe8/FXp6huXzXt60OQP\ni3sOq4XBAAConnTD7vDJf2iX+KT3lj0GXzAqhDBj0oQrfjWwW+e+nyRb3vi3o2tzQgAA0pJu\n2OU3P+DNfz90xE8y/nj9yBDCs5ecf9l1dzfsddT9b759RMsGtTggAADpqcYNiht13v8vT+//\npy8/mvHBvPLM/Dadt2lTlFt7kwEAUC3pht3SpUtXLRVs1nXbyk+bKF+6tDwrOzc3p3ofXwEA\nQG1It8kKCwvXtCsjq6D1lh136d138PnD9+1StJ4GAwCgetJ9j934W8bu0Dg3kZHTc++DTz1j\n6Nlnnn5Yn51yMxLFOxx15mkDenVt/sLdN/Tddsvb3l9Uq+MCALAm6Z6x+0nJ384sazHxjdeO\n2b64auOC/9z7k14nFl717l/7tl7xzazju+00/Oh7TnljSO2MCgDA2qR7xu6ca/7V8bi7V6+6\nEELTbY+8+8QtbjjhvBBCTqOtr75p54Xv/H79zwgAQBrSDbsZy1YWtP2B25o0aNeg9Ot/Vi7n\nt25QsWLeehsNAIDqSDfsftm6cNZNl88pq1h9Y3LFvFE3zCxsNbBy9R+j/5PX9ID1Ox8AAGlK\n9z12w+6/7JadftWt8x6nn9Z/py5b5Iayj2e98ddbb3qpJPO6Vy8pW/TM4Qee/OiLsw8e/49a\nHRcAgDVJN+ya9Thv1jNNB5158TXDz67aWNR5j1ufnnRyj2ZLP/vv8x/knPbb+24Z3KV25gQA\nYB2qcW/hVnsMfPzfAz9778233vl4WUVWiy277rJdx8zUsm8WL2vUcsg3n51Re1MCALBO1f7Q\niJade7bs3LNqdc4Th3Xo987K0o/X61QAAFRbumGXqlgy7pxT7nzqtZLl5atv//yTjxP53Wph\nsB+Qn59fN08EbCK8qlBjWVlZIYREIuGniDqWSqXWsjfdsHtz1J5Dx73eedc+WxXN/OdLn+7X\n79DcUDrjmacTTfe6edKd62POdcvJyambJwI2EV5VqLGMjFW3lfBTRB1LJpNr2Ztu2F1844xm\n3Ue/O214qmJJh8Imu4/78/C2DZfPf677lgcsafUD97erDYsW+bwyYH3yqkKN5eXlFRYWplIp\nP0XUvdzc3DXtSvc+ds9/s6J9/4NCCInMwhM2K3j6jZIQQv5mvf88sP3oI29bL1MCAPBjpBt2\nTbISKxevrFzepU2DuQ/OrVze4vA2C98fUyujAQBQHemG3cmtG75/+28rP3mibb/Wnz76h8rt\nnz/1RW2NBgBAdaQbdoMnnLL8y/s6Frf7qLSi44CTl82/a9dBF14z6tyDrpvedJthtToiAADp\nSPfiiZa9r35zSsvLb304IxEatBw88Zx7j7vh2pdTqUYd+9772OBaHREAgHQk1n43lG8ly8pW\nZuTkZie+2/TNnHc/WprXbet2q2+sPclkcsGCBXXxTDUydOjQ+h4BqLaxY8fW9whsrKquii0p\nKanvWdjkFBcXr2lXWr+KTVUsLirI7/PXD1bf2KjtVtt3qaOqAwBgndIKu0Rm4/O7Nv1wwqu1\nPQ0AADWW7sUTlz7/6HZzzjpj7IMlZRW1OhAAADWT7sUTBx09PLl5u1vOOeyWc/M2b9k8L/t/\nivCjjz6qhdkAAKiGdMMuLy8vhFYHHtiqVqcBAKDG0g27hx9+uFbnAADgR0o37CrNemryxMdf\n+mT+gp/9bnz/7GmvzNuud/fNamkyAACqJf2wS908aPcz7phWuVJw6dgDl4zdq+cjPzv5xidv\nPSPLTU8AAOpbulfFfnDP4WfcMW2fM27493tzK7c06Xz1Vafu+txtZ/Yb/06tjQcAQLrSDbvR\n5z/RtOtFT447e7tOq66fyCroctH4Fy/fttlzI6+otfEAAEhXumF371fLOw78xfe3HzagQ2mJ\n6yoAAOpfumHXLjdz8XvffH/71zMWZea6BwoAQP1LN+wu3mWz9+8e8PJXpatvXDbv6UGTPyzu\nOawWBgMAoHrSDbvDJ/+hXeKT3lv2GHzBqBDCjEkTrvjVwG6d+36SbHnj346uzQkBAEhLumGX\n3/yAN//90BE/yfjj9SNDCM9ecv5l193dsNdR97/59hEtG9TigAAApCfd+9gtrkg16rz/X57e\n/09ffjTjg3nlmfltOm/Tpii3VocDACB96YZd8+JORwwYOGjQoH17bLlT8y1rdSYAAGog3V/F\n9u4UJt54WZ+ebdv02HfE7+/54OsVtToWAADVlW7YPf7qByXvvXLz6PM7Jd+54pzjt2rerPcR\ng+945OXlyVodDwCAdKUbdiGEJh1/cvrwa599+9PPZrxw3cUDV0y/f9DBuzZr2fWkX/2u9uYD\nACBN1Qi7Ki267XbOqBufe/mV68/Yb8WXs26/9qL1PhYAANWV7sUTVZZ/Meuh+6ZMmTLl4Wfe\nLE2mGrfvecwx/WtjMgAAqiXt2518+p/7p0yZMmXKP16YsTKVyt+865FnXnbsscfu32urRK0O\nCABAetINu6J22ydTqZzG7fudfOGx/fv326tHtqADANiQpBt2+x13Vv/+/Q/fv1eDjP8JulRy\n2eKloVHDglqYDQCAakg37P5+1+9/cPunTx7Wod87K0s/Xn8jAQBQE+mGXapiybhzTrnzqddK\nlpevvv3zTz5O5HerhcEAAKiedG938uaoPYeOm/RN0ZZbtSyfPXt2l+16bL9dl6ySeYmme938\n4GO1OiIAAOlI94zdxTfOaNZ99LvThqcqlnQobLL7uD8Pb9tw+fznum95wJJWDWp1RAAA0pHu\nGbvnv1nRvv9BIYREZuEJmxU8/UZJCCF/s95/Hth+9JG31eKAAACkJ92wa5KVWLl4ZeXyLm0a\nzH1wbuXyFoe3Wfj+mFoZDQCA6kj3V7Ent254ze2/nXP55La5mW37tf50zB9C2C2E8PlTX9Tm\neAAbvaFDh9b3CEC1jR07tr5HqIl0z9gNnnDK8i/v61jc7qPSio4DTl42/65dB114zahzD7pu\netNthtXqiAAApCPdM3Yte1/95pSWl9/6cEYiNGg5eOI59x53w7Uvp1KNOva997HBtToiAADp\nSDfsQgjbH3bufYedW7l8zPVP7H/uux8tzeu2dTufLQYAsCGoRtj9P43abrX9ehwEAIAfJ933\n2AEAsIETdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAA\nkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYA\nAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2\nAACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQ\ndgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAC7iRPoAABgpSURB\nVJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkciq4+e74/QT80aN7988/9sN\nyWcn3fzw1DfmLM7s0n3ngWcN6lBQ1yMBAMShLs/Ypd57/o/3z1tYnkpVbfpwyiVjJr/U6/BT\nLjtnQOEHTw0/99ZkHQ4EABCTOjo9Nv+lG4bd+ELJkhX/szW14vrJMzsee+1R+3YMIXS6OnHU\ngKvvmTvwhNYN6mYqAICY1NEZu6Jtjho+6rfX/m7Y6hvLFk39pLSiT5/Wlau5Rbv3LMx5/dnP\n62YkAIDI1NEZu5xGrTs1ChUr8lbfuGLp2yGEbgXZVVu6FmQ99vaicNyq1QcffHDGjBmVy/n5\n+aeffnrdTAtsIgoLC+t7BGADtcG+PiSTa3vbWn1eqZAsWxpCaJb13VnD4uzM8iWlVauvvvrq\nY489VrncpEmTc889t44nBOKWl5e37gcBm6QN9vWhoqJiLXvrM+wycvJDCF+XJwszMyu3lKys\nyCzKqXpAq1atunbtWrlcWFhYXl5e90MCEfOqAqzJBvv6kEwmM78Np++rz7DLbrBtCFNnLS9v\nm7tqvveWlzfevajqAUOGDBkyZEjlcjKZXLBgQT1MCcRr4cKF9T0CsIHakF8fiouL17SrPm9Q\nnFe0V6uczMdfmF+5unLpW/9avGKHfVvU40gAABuvev3kiUTOBUd2ef+OkU++PuuzD6dPGHFd\nQct9BrTZQN+rCACwgavnj3nodMzoIWU3TBozoqQ00XH73qNHneIzzgAAaqZOwy4zp81DDz30\nP5sSmX1OPL/PiXU5BQBAnJwgAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIhEVn0PUA0NGjSo7xGAqHhVAdZk\ng319SCaTa9m7MYVdRobzi8D65FUFWJMN9vUhkUisZe/GFHaLFy+u7xGAqHhVAdZkQ359yMvL\nW9OuDbRGAQCoLmEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABCJrPoeIPnspJsfnvrGnMWZXbrvPPCsQR0K6n0kAICN\nUj2fsftwyiVjJr/U6/BTLjtnQOEHTw0/99Zk/Q4EALDRqtewS624fvLMjseOOmrfXbfZcY+z\nrz5z6WeP3zN3aX2OBACw0arPsCtbNPWT0oo+fVpXruYW7d6zMOf1Zz+vx5EAADZe9fmGthVL\n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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# average ride duration between members and casual riders in general version\n",
    "\n",
    "all_trips_v2 %>% \n",
    "  group_by(member_casual) %>% \n",
    "  summarise(average_duration = mean(ride_length)) %>% \n",
    "  ggplot(aes(x = member_casual, y = average_duration)) +\n",
    "  geom_col(position = \"dodge\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 26,
   "id": "7fe18b3c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:39:29.049847Z",
     "iopub.status.busy": "2022-03-29T18:39:29.048345Z",
     "iopub.status.idle": "2022-03-29T18:39:41.168144Z",
     "shell.execute_reply": "2022-03-29T18:39:41.166092Z"
    },
    "papermill": {
     "duration": 12.336882,
     "end_time": "2022-03-29T18:39:41.168372",
     "exception": false,
     "start_time": "2022-03-29T18:39:28.831490",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t4588104 obs. of  15 variables:\n",
      " $ ride_id           : chr  \"B9F73448DFBE0D45\" \"457C7F4B5D3DA135\" \"57C750326F9FDABE\" \"4D518C65E338D070\" ...\n",
      " $ rideable_type     : chr  \"classic_bike\" \"electric_bike\" \"electric_bike\" \"electric_bike\" ...\n",
      " $ started_at        : chr  \"2021-01-24 19:15:38\" \"2021-01-23 12:57:38\" \"2021-01-09 15:28:04\" \"2021-01-09 15:28:57\" ...\n",
      " $ ended_at          : chr  \"2021-01-24 19:22:51\" \"2021-01-23 13:02:10\" \"2021-01-09 15:37:51\" \"2021-01-09 15:37:54\" ...\n",
      " $ start_station_name: chr  \"California Ave & Cortez St\" \"California Ave & Cortez St\" \"California Ave & Cortez St\" \"California Ave & Cortez St\" ...\n",
      " $ start_station_id  : chr  \"17660\" \"17660\" \"17660\" \"17660\" ...\n",
      " $ end_station_name  : chr  \"Wood St & Augusta Blvd\" \"California Ave & North Ave\" \"Wood St & Augusta Blvd\" \"Wood St & Augusta Blvd\" ...\n",
      " $ end_station_id    : chr  \"657\" \"13258\" \"657\" \"657\" ...\n",
      " $ member_casual     : chr  \"member\" \"member\" \"casual\" \"casual\" ...\n",
      " $ date              : Date, format: \"2021-01-24\" \"2021-01-23\" ...\n",
      " $ month             : Ord.factor w/ 12 levels \"01\"<\"02\"<\"03\"<..: 1 1 1 1 1 1 1 1 1 1 ...\n",
      " $ day               : chr  \"24\" \"23\" \"09\" \"09\" ...\n",
      " $ year              : chr  \"2021\" \"2021\" \"2021\" \"2021\" ...\n",
      " $ day_of_week       : Ord.factor w/ 7 levels \"Sunday\"<\"Monday\"<..: 1 7 7 7 1 6 3 7 4 6 ...\n",
      " $ ride_length       : num  7.22 4.53 9.78 8.95 10.15 ...\n",
      "'data.frame':\t4588104 obs. of  16 variables:\n",
      " $ ride_id           : chr  \"B9F73448DFBE0D45\" \"457C7F4B5D3DA135\" \"57C750326F9FDABE\" \"4D518C65E338D070\" ...\n",
      " $ rideable_type     : chr  \"classic_bike\" \"electric_bike\" \"electric_bike\" \"electric_bike\" ...\n",
      " $ started_at        : chr  \"2021-01-24 19:15:38\" \"2021-01-23 12:57:38\" \"2021-01-09 15:28:04\" \"2021-01-09 15:28:57\" ...\n",
      " $ ended_at          : chr  \"2021-01-24 19:22:51\" \"2021-01-23 13:02:10\" \"2021-01-09 15:37:51\" \"2021-01-09 15:37:54\" ...\n",
      " $ start_station_name: chr  \"California Ave & Cortez St\" \"California Ave & Cortez St\" \"California Ave & Cortez St\" \"California Ave & Cortez St\" ...\n",
      " $ start_station_id  : chr  \"17660\" \"17660\" \"17660\" \"17660\" ...\n",
      " $ end_station_name  : chr  \"Wood St & Augusta Blvd\" \"California Ave & North Ave\" \"Wood St & Augusta Blvd\" \"Wood St & Augusta Blvd\" ...\n",
      " $ end_station_id    : chr  \"657\" \"13258\" \"657\" \"657\" ...\n",
      " $ member_casual     : chr  \"member\" \"member\" \"casual\" \"casual\" ...\n",
      " $ date              : Date, format: \"2021-01-24\" \"2021-01-23\" ...\n",
      " $ month             : Ord.factor w/ 12 levels \"01\"<\"02\"<\"03\"<..: 1 1 1 1 1 1 1 1 1 1 ...\n",
      " $ day               : chr  \"24\" \"23\" \"09\" \"09\" ...\n",
      " $ year              : chr  \"2021\" \"2021\" \"2021\" \"2021\" ...\n",
      " $ day_of_week       : Ord.factor w/ 7 levels \"Sunday\"<\"Monday\"<..: 1 7 7 7 1 6 3 7 4 6 ...\n",
      " $ ride_length       : num  7.22 4.53 9.78 8.95 10.15 ...\n",
      " $ started_at_hour   : POSIXct, format: \"2021-01-24 19:15:38\" \"2021-01-23 12:57:38\" ...\n"
     ]
    }
   ],
   "source": [
    "str(all_trips_v2)\n",
    "all_trips_v2$started_at_hour <- as.POSIXct(all_trips_v2$started_at, \"%Y-%m-%d %H:%M:%S\")      \n",
    "str(all_trips_v2)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 27,
   "id": "ce345931",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:39:41.603358Z",
     "iopub.status.busy": "2022-03-29T18:39:41.601273Z",
     "iopub.status.idle": "2022-03-29T18:39:46.228205Z",
     "shell.execute_reply": "2022-03-29T18:39:46.227407Z"
    },
    "papermill": {
     "duration": 4.845379,
     "end_time": "2022-03-29T18:39:46.228363",
     "exception": false,
     "start_time": "2022-03-29T18:39:41.382984",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nOzdd5hU5dnA4XfK9kK3giYiYsGCJWosGGuwxljAGnvvvSLBFjt2jJ8txtgbNhIb\nYotRo1FU0IidqEhdyi7bvj9GCbEMw5bZ4eW+Ly+v2Zmz73nmLI4/zszOJJqbmwMAAIu+ZEcP\nAABA2xB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACRSHf0AB2gubl52rRp+dlX\nRUVFOp2ur6+fPXt2fvbYMmVlZSGEOXPmdPQg2ZSVlRUXFzc0NMyaNaujZ8mmpKQklUoV+E+8\ntLS0pKSksbFx5syZHT1LNsXFxUVFRYX/Ey8tLW1qaqqpqenoWbIpKioqLS0t8CGLi4szD0fT\np0/v6FmySafT5eXlM2bM6OhB/keXLl06egQ63mIado2NjXnbXTKZDCHkc48tVuBDJhKJZDKZ\nSCQKfM4QwiIxZDKZbGpqKvA5m5ubC/9gNjc3LxL/mafTaQezrSSTyWQyWeBDsnjyVCwAQCSE\nHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAk\nhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBA\nJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAk0h09\nAABto8fY8dk3aNhkg/xMAnQUZ+wAACIh7AAAIuGpWAC+tcAncyf165ufSYCWccYOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACAS6Y4eoGOUlJTkZ0fJZDLz77ztsWVSqVTI42FpmUXlYKbT6cIfMvMTL/w5F4mDmU6nQwiJ\nRKLA5wxtMWR738fMwczDjlqpAB8z6+rqOnoECsJiGnbl5eX52VGmRdLpdN722DKZOReJIZPJ\n5CIx5yIxZCKRKPA5E4nEIjFkWBQOZmiL/3za+z5mDmYedtRKBfgnU9iRsZiG3dSpU/Ozo+rq\n6uLi4rlz59bU1ORnjy1TWVkZQpg5c2ZHD5JNVVVVSUlJQ0PD9OnTO3qWbMrLy9Pp9IwZMzp6\nkGwqKirKysoaGxunTZvW0bNkU1paWlJSUuA/8bKysoqKiqamprw9sLRYY2NjK4ds7/tYWlqa\neTgq8INZVFRUXV1d4EOyePIaOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7\nAIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgI\nOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBI\nCDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCA\nSAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsA\ngEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7\nAIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgI\nOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBI\nCDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCA\nSAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsA\ngEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7\nAIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgI\nOwCASAg7AIBICDsAgEgIOwCASKTzs5vmhqkP3njDEy/9a3JtculefXbc57Bt+i/V0sWaRt91\n3SNj/vlZTWrlfr/Y7+j9VyhPhxC+evnMgy98e/7tDrjlnt90K2317AAAi4Y8hd3fLjjpjner\n9zvkmJWXqXjr6TuvG3rknGtu+02vyhYsNeH+s664+5O9jzzqgC4Nj91w7ZnHz73jhiOTIUx7\nc1pZtx2OPXi1eVsuX1XUdvcAAKDQ5SPsGus+G/H6NwMuuHSH1bqEEPqsvPp//jHooevG/ubC\n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\nkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkfCRYgDQEtk/tS+EUHPykPxMAvM4YwcA\nEAln7ADg+0oHDgpjx2fZoGnAL/M2DOTOGTsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBI\nCDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCA\nSAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsA\ngEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEikO3oA4MdV\nXTIsy621IZQOHJS3YQBYJDhjBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEInF9JMnKioq8rOjVCoVQkin03nbY8uk0+mQx8PSMpkhU6lUgc9ZXFycSCRaOWTr\n72McK4QQUqlUU0ePEccKIYRksrV/mS+EO9ImhyI/DyP5fLCaNWtW3vZFIVtMw671j27/Y8jJ\nP3VLQwgNIRRdOLyN99jWEolEaPPD0m4KfM5EIpFIJFo5ZOvvYxwrtIlCuCOFsEKbKIQ70iaH\novWLZB4223svsLAW07Crqalpw9WqFrRBfX192+6xzVVWVoYQZs6c2dGDZFNVVZVKpRobGwv8\nYNbV1aXT6VYOWVNTs8A/V4vECiGH/0Cya2xsbN0ChXIoCuFgNjW18uxnPIei9WM0NzfnspfW\n7QQWmr9MAABEYjE9YwcA7ap04KAwdnyWDSb165u3YVh8OGMHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlvUMzipUfW9wsN3jIUgEWZM3YAAJEQdgAAkfBULLSLqkuG\nZbm1NvM5kgDQppyxAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIhEuqMHIIQQqi4Zln2DmpOH5GcSAGDR5YwdAEAkhB0AQCSEHQBA\nJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkfKRYuysdOCi8/FqWDSb165u3\n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\nPe8B+LXcDwAAAABJRU5ErkJggg=="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# average number of rides for by hour between members and casual riders\n",
    "\n",
    "all_trips_v2 %>%\n",
    "  group_by(hour_of_day = hour(round_date(started_at_hour, 'hour'))) %>% \n",
    "  group_by(hour_of_day, member_casual) %>% \n",
    "  summarise(number_of_rides = n(), .groups = 'drop') %>% \n",
    "  arrange(-number_of_rides) %>% \n",
    "\n",
    "  ggplot(aes(x = hour_of_day, y = number_of_rides, fill = member_casual)) +\n",
    "  geom_col(position = 'dodge')"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 28,
   "id": "25a14518",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:39:46.679934Z",
     "iopub.status.busy": "2022-03-29T18:39:46.678187Z",
     "iopub.status.idle": "2022-03-29T18:39:47.116380Z",
     "shell.execute_reply": "2022-03-29T18:39:47.115816Z"
    },
    "papermill": {
     "duration": 0.667613,
     "end_time": "2022-03-29T18:39:47.116510",
     "exception": false,
     "start_time": "2022-03-29T18:39:46.448897",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\nPDhjUljnl+f1LvH3vs2zI2cXf2pTxwD39DlXjhq301Bv2OjXzCkX1i8efSoxzRFt1oyetse7\n6bBJvYuYbEe/X71y7shmDTYEm3Qi8tn4Oc17DOldu8T5fZtnR84OfGJjlyCPLBVd2ftOmmro\n0yjIy9QjyPT5d2tOdB1bV0Qa9H1o6bh1F1PbhJj0InJq7VfuAW2a+ZpEJGrcKzuSavR7aUQp\nH+XE3m1vju1vW/Zuy5CsPTcfO35D91cHDFrvWebp+XO65zhyNy5+bFPVF+oFZH+rcueHrP/b\ntj8+taG3Kcd1LHJrytT4E1NfnpxjqhORPm1rvbphyYsj9zzeuEFo7drVKpUymcvXr19eRPqs\niCo2uNeOWuPe6Fctx/LsdntMTEyObwHIUb4fmbS0tOTkgryc94GTnJxcmEfAarUmJSW5ugpX\nSkpKeqBHQK/X+/vncDTHQSPX2IlIlZ5No4+sTLKrIpJwcf15e7Gepb2yTxZ/fvV3/1jHz3ql\n8UPVqtZuPGRmr7J+f8bcupTMP3RExFMNSxYr0bjt8BJu+uPRKekzJl59f/vfN0bOHNIwtErt\nhs3HTQ1Lu3XsJ6hVxyGT+tavUbl8pWqtOndS7UmnU6yOtzwbjYpo2bBUsRKN2w4vZzacuJrD\nn5LPo055lexWzqxXdO69q/hdPfBOsqqKiF/lvkX0aauORIuIqGmR+65W691GRJKvb/nwZNz4\nOSMer1+rQuWaz0SM6RNi3PjW0Szd2pL/XjF7bkpI3eTLySUfeiLIqIv/49cTZ7PeYpJ0OUFR\nlLK3jllmZPAoKyJ/p9jyXsdUy4lpL0+6Ur1HjqlORKp0nbp4xqtNy3v9/PXmSaNe7ty5x6S5\ny3+5kiwiBpObSVF0BpObmzGHOQEAwO3QyhE7Ea+QF8roPnn3rGVged+T7/1QtE5/NyWHlHF9\n33Gj10M1PG6uuLlIq9dea5X+bomn/72ezEefKfXGHDmkN1eo63Uzf3iXekbkE8e/w9uFHdm3\n56NzFy5f/ufM8f0Z5yr2VOYOs50GTI0/sOVaUuUXy547d05EfFqUth35efVpy8AKvore+6Ua\nRZat+UnqPRN/ft25NPeJjYJEJOH8IVVVx3d9PmM/ntYLIg0yNKgrho85UDx85aLO8ftX9Zs9\nqkK5lb7L50V5j4ycGppxRnOQl6qqfyXbymXLdrbkv0WkpJs+73VcPnyq3axLOHM2j3OcZUKb\n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\nNIpIhco1bfu6bXzraJ02n/+ebJ73+qiKZr2IVKnm3rn7ayJy9dDSHNuz+zzqlFfJbuXMehH3\n3lX85h14J1ldZlaU6N+WHU5wm/fOrR6q++5/YWLe6xXUquOQFs/W9zWJSMlind7ZOv10ijXY\nZBKRuOCXujxZ2/khqtB3/NP1S4hIpwGVt485OGVcRBk3vZQNaR8QtfNonOQS7AAAgPMIdgWm\nTGjT3qFNRSQp+sLhA/s+e3/T1EGH31i3pIybXkRKPF0mfUofvU5EEs4fUlV1fNfnM3biab1w\ndecFs39LR/YSEZN3w3pexusiubVnkRp/YMu1pMovlj137pyI+LQobTvy8+rTloEVfC//72zG\nHowetRp6my7luVLh7cKO7Nvz0bkLly//c+b4/oxvFW9R6rbGx6+aj+MfBk+jzhjoGJabo5H7\n6VGdTufnl9s55ztx48aNAuwNhVbB7pb3040bN/R6vdlsdnUhrhEfH2+z2dzc3Nzd3V1di2sk\nJCQYjUY3NzdXF+IaFovFbrebzeYH+iOgKHldq06wKwCplt3zlnzfc9SYkia9iLgXKdG4Zfv6\nj1Z5vsu4dX/Fj6/sJyLuHvoscxk8TYrec9OG1RkbFZ3xjyU7skzpa9BdFxFd1g15sz2z89vX\nqar6e+TUwRka90UeHjjrMXtq1ksKDJLzzpGmqiJiT7s2c9Dgk57VWzWpU6NB1afCHxsxdHr6\nNB7e+e88abkmttu4ncNgKMi9NO/PA+Ckgt0t7yfH1TkPbv13yfEXoJCPQCFffdH6DsBz7AqA\n3lR8/759mw5lSlm25FgRKeZlzG0uj+BWYk/cEW0z3+S2/rUpS7/7J6hZieTYr84k22718+ce\nS4qI5Naexfqtf3uX6bU1g3H1g2KPr4yxqgGNgzP2YE088WP8vz0kWG+GsJS43Qk2VUQSzkce\nvJK6ZP6kHh3DmzWuV8o/wZnRyN4PAAC4Pwh2BUBvLj+uTZWdc4YtWbflp0O/Hj16ZPfXW2YM\nf8O7XFjP4p65zWXyrt+3TtG1Y2bu2HXw7OnfP1k+9tPj15s3CQqoM6iyKXHSuIV7Dh07cXjv\novFTvN30IpJbe0bJ1z79KT61wYAnMjbW7tvCbotbcfR6YMOBpQwJvYNk+AAAIABJREFU6T28\nMX7GzYOAirGKh3Hnks1/XLjy14mDb05c5vg/jdG7kqpaP9555Mq1yycOfTt3whoROXcp1p7b\n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\nDgAAQBIEOwAAAEkQ7AAAACRBsAMAAJAEwQ4AAEASBDsAAABJEOwAAAAkQbADAACQBMEOAABA\nEgQ7AAAASRDsAAAAJEGwAwAAkATBDgAAQBIEOwAAAEkQ7AAAACRBsAMAAJCE2tUFAPfb1Zb1\ntVqth4eHqwtxjbS0NKVSaTQaXV0IAKDkccYOAABAEgQ7AAAASRDsAAAAJEGwAwAAkATBDgAA\nQBIEOwAAAEnwuhOUOuWO/eTqElzp4XjLS9cgV1cAAA8lztgBAABIgmAHAAAgCYIdAACAJAh2\nAAAAkiDYAQAASIJgBwAAIAmCHQAAgCQIdgAAAJIg2AEAAEiCYAcAACAJgh0AAIAkCHYAAACS\nINgBAABIgmAHAAAgCYIdAACAJAh2AAAAkiDYAQAASIJgBwAAIAmCHQAAgCQIdgAAAJIg2AEA\nAEiCYAcAACAJgh0AAIAkCHYAAACSINgBAABIgmAHAAAgCWmDndOe9mn82xPDh/Xr06tv/+cn\nzlx84GxK9qcDe/V862J6EbvKvHmqR48ep25m3rHlqc+2TI8Y/VxIr5DnBoVPjNr6eUL2R+mX\nLlxKtua7ljXt9FvTXxkY0m/kuJn7f0srqPNVQ/oNj/o+7/IePXqsvXyzCOMoqmLtnCxOu2lI\nn+AePXr8J9lcgpUAAIBikTPYOR03V7wavmrP2Ue6DJoyffrLIwdVFWfemDxq74Ub/95Gf/9w\nzmvLtpdv3m3qrOi5r03o9ki5D5ZPmb3rXNanB6Mmzd1yLt8VN06Zl1C+85tr3glrZVk2NdpZ\nzO127do1UK++t9rvVfJPMck2Ud5NtWvbb66tBACA0szFgeBfcmbDtM8veC1Yt7CO0S1ryZPt\nnta/GLpx/u6uK54rVld2S1Gz4Lqt3/u1n/HyoCZZvwY2albP8GtE3P+JnjGFr7j/0o3W04LK\nexnLdOti3brYZHd6qhRFr3D06NG5a3Y4Vcpi9HBHd+zwcOz3+vK9wqsfnPflOseL0XL+uQAA\nwANPxv8FOzMX7/6t1vOvZqc6IYRQqPtNHNmngyFXW2tq4jvzIgf37xfcO2TEmCnbD13IWj6w\nV8/df11dGz1tyIglt7U3JUQ+HzLuzT32PCfWbtqdluTLOZdU7frStCkjnUKsGtLvnUvpf+yd\n1Dc0Om+9oY18jq3+3Om07I3Z7Fk7pFipTggR0rNn1qXYsN7B2//4cXb48717BQ8aMnLZ1iNZ\n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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# T10 start stations for casual riders\n",
    "\n",
    "all_trips_v2 %>% \n",
    "  group_by(start_station_name, member_casual) %>% \n",
    "  summarise(number_of_rides = n(), .groups = 'drop') %>% \n",
    "  filter(start_station_name != \"\", member_casual != \"member\") %>% \n",
    "  arrange(-number_of_rides) %>% \n",
    "  head(n=10) %>%\n",
    "\n",
    "  ggplot(aes(x = reorder(start_station_name, number_of_rides), y = number_of_rides)) +\n",
    "  geom_col(position = 'dodge', fill = 'lightpink') +\n",
    "  scale_y_continuous(labels = scales::comma) +\n",
    "  labs(title = 'Top 10 Start Stations for Casual Riders', x = '', y = \"Number of Rides\") +\n",
    "  coord_flip() +\n",
    "  theme_minimal()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 29,
   "id": "92b3332d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-29T18:39:47.562457Z",
     "iopub.status.busy": "2022-03-29T18:39:47.560330Z",
     "iopub.status.idle": "2022-03-29T18:39:48.134312Z",
     "shell.execute_reply": "2022-03-29T18:39:48.133555Z"
    },
    "papermill": {
     "duration": 0.79813,
     "end_time": "2022-03-29T18:39:48.134452",
     "exception": false,
     "start_time": "2022-03-29T18:39:47.336322",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\nAAC8Tv4dsfth+siVP13qNOD5N6eMaRWeuGji0LVnY1L1Ofnlq3M+29Ww69MTXuznf2Lz+JeW\nOHLUntdjAgAAeKF8Cnb2xLOL915t9trrj7RqVKFyzW5Dp7cJ1q9ddDBFJzVp9md/h/ee3OPB\nRtXua/bCzGGxF75feS422+15PSYAAIBXyq9gl/Bv6bJl25cLvNWg1AkyWaNSHLFLjN5+JsHe\npk1x50NTcNM6/j57t13MbntejwkAAOCd8unqMZ+gZnPnNkt+aI058sH5mNIDKrn2SYo9ICJV\nLcbklioWw8YD0UkPZK9d+uThmCdOnLh27ZrzZ51OV6FChexuijylKIqI6PV6o9GYZWfN0Ov1\nIqIoirettdVqzegpvV7vfLO8hE6nE6/chnnKOXNExGAwOLeAl7Db7Rk95W3vkcFw84+I0Wh0\nOO6h61a8c2erqqqnS4DneeBjAad/Xz9/3gfWcu3GP1zCtd2RGCsiBQy3d69hRr0tJiG77Xk6\n5vLlyzdu3Oj8OSQkZNOmTTnYAnnNZDKZTCZPV5HfdDpdUFCQp6tIISIiIqOnLBZLcqrwHnq9\n3tu2Yf4ICAjwdAkpxMSkvv44mcFgMJvN+VmMm7xtG+YPX19fX19fT1dxW2JioqdLgOfla7BL\nivzngwXzN/wR0aL7kGmPt/JNecRC52MWkUibw//WH7xrVrs+2Ce77Xk9JgAAgHfKv2B34/Tm\nESMX6mu0m7m0X6WwdP6LY/SrIbL9n3hbSdPNUHUs3hbUNDi77Xk65vjx40ePHu38WVXV5NOy\nXiI4OFiv18fHx8fFxXm6lvxjsVjMZrPdbo+KivJ0LSlkclokJibGZrPlZzGZ8/Pz8/X1tdls\n0dHRnq4l/xgMBucRyqioqEzOfuY/VVX9/f3TfcpqtV6/fj2f68mE0WgMDAwUkcjIyHvqVGxo\naKiiKLGxsQkJCVn3zkf34OkapJJPwU51xE0bs8jU+vn5z7bM6MIi3+CWxXwWf7/j8oMdS4qI\nNXb/7htJXR8s4htcKlvteTqm2WxOPg/icDgyOdfmQaqq3lNXWiSv7F201t72Ht2N2zD3XNf6\nLlpxryr1Lt2GuaeqqvMyu3tqrXFX0E+cODEfFhN3acXir/7u2rV17OWL52+5HGkpUsj35OqP\n1+45Wad2ZVH0lR1/fvbJd2Hhlc0JF1fNfOucqenkPs2V7LaL5MWYaamqGh8fnw9bz31ms1mn\n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\nrkJggg=="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# usage of different bike types between members and casual riders\n",
    "\n",
    "all_trips_v2 %>% \n",
    "  group_by(rideable_type, member_casual) %>% \n",
    "  summarize(number_of_rides = n(), .groups = 'drop') %>% \n",
    "  drop_na() %>% \n",
    "\n",
    "  ggplot(aes(x = member_casual, y = number_of_rides, fill = member_casual)) +\n",
    "  geom_col(position = \"dodge\") +\n",
    "  scale_y_continuous(labels = scales::comma) +\n",
    "  facet_wrap(~rideable_type) +\n",
    "  labs(fill = \"Member/Casual\", x = \"\", y = \"Number of Rides\", \n",
    "       title = \"Usage of Different Bikes: Members vs. Casual Riders\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ad214367",
   "metadata": {
    "papermill": {
     "duration": 0.223688,
     "end_time": "2022-03-29T18:39:48.588951",
     "exception": false,
     "start_time": "2022-03-29T18:39:48.365263",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Key Findings:\n",
    "1. In general, casual riders have longer average riding duration than members.\n",
    "\n",
    "2. During the day of week from Monday to Sunday, casual riders’ riding length steadily increases and reaches a peak on the weekends. While members remain almost the same amount of time in riding, the riding duration goes up slightly on the weekends too.\n",
    "\n",
    "3. Also, it shows that the average numbers of rides for casual riders remain about the same level from Monday to Thursday, and then significantly increase from Friday, and reach a peak on Saturday and come down a bit on Sunday. However, the average numbers of rides for members remain quite the same throughout the week, and they reach a little peak on Wednesday and go down a little bit towards the end of week.\n",
    "\n",
    "4. Analysis has also shown that there is a seasonal trend for both members and casual riders, that is, both of them prefer to use bikes more in the summertime. For casual riders, you can see that the average number of rides jumps to the top in the summertime and reaches a peak in July, and decreases over fall time and then a big jump off towards the winter time. For the members, the numbers are less dramatic, but still there is a little peak in August.\n",
    "\n",
    "5. During the day, both members and casual riders have more usage of bikes around 5 or 6 pm in the afternoon than any other time during a day. But what needs to be pointed out is that members use bikes more often than casual riders in the morning around 7,8 or 9 am, while casual riders seem to use bikes a little more often around midnight or after.\n",
    "\n",
    "6. The top 3 most popular stations and start stations with casual riders are Streeter Dr & Grand Ave, Millennium Park and Michigan Ave & Oak St.\n",
    "\n",
    "7. The most popular bike type for both members and casual riders is classic bikes, and the least popular one is docked bikes."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "fbc18d80",
   "metadata": {
    "papermill": {
     "duration": 0.225204,
     "end_time": "2022-03-29T18:39:49.037807",
     "exception": false,
     "start_time": "2022-03-29T18:39:48.812603",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**ACT**\n",
    "\n",
    "**Recommendations:**\n",
    "\n",
    "1. Based on the analysis, casual riders seem to have longer average riding duration, so Cyclistic can limit the riding length by charging casual riders extra fee if they ride over 20 minutes or do not return the bikes after full-day passes expire. Or cyclistic can inform casual riders about the benefit of getting membership if they need to ride over 20 minutes or can’t return bikes at the end of the day.\n",
    "\n",
    "2. In the summertime or nice weekends, Cyclistic can offer new riders or existing casual riders a discount on getting new membership or benefit of membership at local businesses or touring spots.\n",
    "\n",
    "3. Cyclistic can also launch marketing campaigns or digital media marketing around the top 10 most popular stations, especially the start stations by casual riders, focusing on sharing the information of the benefit of membership.\n"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 312.073259,
   "end_time": "2022-03-29T18:39:49.572449",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-03-29T18:34:37.499190",
   "version": "2.3.3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
